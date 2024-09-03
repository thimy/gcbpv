module WithAttachment
  extend ActiveSupport::Concern

  def save_attachments
    content = parsed_content(self.content)
    file_blocks = filter_file_blocks(content)

    file_blocks.each do |file_block|
      signed_id = extract_signed_id(file_block)
      existing_file = find_existing_file(signed_id)

      if existing_file.nil?
        create_and_associate_file(signed_id)
      else
        update_existing_file(existing_file)
      end
    end

    delete_unused_files(content)
    delete_unassociated_files
  end
  
  private

  def parsed_content(self_content)
    JSON.parse(self_content)
  end
  
  def filter_file_blocks(content)
    content["blocks"].select { |block| block["type"] == "image" || block["type"] == "attaches"}
  end

  def extract_signed_id(file_block)
    url = file_block["data"]["file"]["url"]
    url_segments = url.split("/")
    url_segments[-2]
  end

  def find_existing_file(signed_id)
    Attachment.find { |file| file.file.signed_id == signed_id }
  end

  def create_and_associate_file(signed_id)
    attachable_file = Attachment.new(attachable: self)
    attachable_file.file.attach(signed_id)
    attachable_file.save
    attachable_files << attachable_file
  end

  def update_existing_file(existing_file)
    existing_file.update(attachable_id: id)
  end

  def delete_unused_files(content)
    files_to_delete = attachments.reject do |attachable_file|
      signed_id = attachable_file.file.signed_id
      content["blocks"].any? { |block|
        block["type"] == "file" && block["data"]["file"]["url"].include?(signed_id)
      }
    end

    files_to_delete.each(&:destroy)
  end

  def delete_unassociated_files
    Attachment.where(attachable_id: nil).destroy_all
  end
end
