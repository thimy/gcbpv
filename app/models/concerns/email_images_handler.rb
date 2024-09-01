module EmailImagesHandler
  extend ActiveSupport::Concern

  def save_email_images
    content = parsed_content(self.content)
    image_blocks = filter_image_blocks(content)

    image_blocks.each do |image_block|
      signed_id = extract_signed_id(image_block)
      existing_image = find_existing_image(signed_id)

      if existing_image.nil?
        create_and_associate_image(signed_id)
      else
        update_existing_image(existing_image)
      end
    end

    delete_unused_images(content)
    delete_unassociated_images
  end
  
  private

  def parsed_content(self_content)
    JSON.parse(self_content)
  end
  
  def filter_image_blocks(content)
    content["blocks"].select { |block| block["type"] == "image"}
  end

  def extract_signed_id(image_block)
    url = image_block["data"]["file"]["url"]
    url_segments = url.split("/")
    url_segments[-2]
  end

  def find_existing_image(signed_id)
    email_images.find { |image| image.image.signed_id == signed_id }
  end

  def create_and_associate_image(signed_id)
    email_image = EmailImage.new(email: self)
    email_image.image.attach(signed_id)
    email_image.save
    email_images << email_image
  end

  def update_existing_image(existing_image)
    existing_image.update(email_id: id)
  end

  def delete_unused_images(content)
    images_to_delete = email_images.reject do |email_image|
      signed_id = email_image.image.signed_id
      content["blocks"].any? { |block|
        block["type"] == "image" && block["data"]["file"]["url"].include?(signed_id)
      }
    end

    images_to_delete.each(&:destroy)
  end

  def delete_unassociated_images
    EmailImage.where(email_id: nil).destroy_all
  end
end
