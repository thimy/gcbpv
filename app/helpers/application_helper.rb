module ApplicationHelper
  include Pagy::Frontend

  def dynamic_fields_for f, association, name = "Ajouter"
    # stimulus:      controller v
    tag.div class: "flow", data: {controller: "dynamic-fields"} do
      safe_join([
        # render existing fields
        f.fields_for(association) do |ff|
          yield ff
        end,

        # render "Add" button that will call `add()` function
        # stimulus:         `add(event)` v
        button_tag(name, class: "button", data: {action: "dynamic-fields#add"}),

        # render "<template>"
        # stimulus:           `this.templateTarget` v
        tag.template(data: {dynamic_fields_target: "template"}) do
          f.fields_for association, association.to_s.classify.constantize.new,
            child_index: "__CHILD_INDEX__" do |ff|
              #           ^ make it easy to gsub from javascript
              yield ff
          end
        end
      ])
    end
  end

  def get_emails(list)
    list.map { |element| element.subscription.email }.reject {|email| email.nil?}.join(", ")
  end

  def format_phone(phone)
    phone.phony_formatted(normalize: :FR) if phone.present?
  end

  def format_date(date)
    date.strftime("%d/%m/%Y") if date.present?
  end

  def format_time(time)
    time.strftime("%H:%M") if time.present?
  end

  def display_editor_content(content)
    return if content.blank?
    parsed_content = JSON.parse(content)
    content_html = parsed_content["blocks"].map do |block|
      case block["type"]
      when "paragraph"
        "<p>#{block["data"]["text"]}</p>"
      when "header"
        "<h#{block["data"]["level"]}>#{block["data"]["text"]}</h#{block["data"]["level"]}>"
      when "list"
        list_items = block["data"]["items"].map { |item| "<li>#{item}</li>" }.join
        "<ul>#{list_items}</ul>"
      when "code"
        escaped_code = CGI.escapeHTML(block["data"]["code"])
        "<pre><code>#{escaped_code}</code></pre>"
      when "image"
        url = block["data"]["file"]["url"]
        caption = block["data"]["caption"]
        with_border = block["data"]["withBorder"]
        with_background = block["data"]["withBackground"]
        stretched = block["data"]["stretched"]
        container_classes = ["image-container"]
        container_classes << "image-border" if with_border
        container_classes << "image-background" if with_background

        image_classes = ["image"]
        image_classes << "image-stretched" if stretched
        image_classes << "image-with-background" if with_background

        container_class = container_classes.join(" ")
        image_class = image_classes.join(" ")

        image_html = <<-HTML
          <figure class="#{container_class}">
            <img src="#{url}" alt="#{caption}" class="#{image_class}" />
            <figcaption class="centered-content">#{caption}</figcaption>
          </figure>
        HTML
      else
        ""
      end
    end
    content_html.join.html_safe
  end
end
