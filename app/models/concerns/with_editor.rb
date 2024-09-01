module WithEditor
  extend ActiveSupport::Concern
  require "action_view"

  def formatted_content
    return if content.blank?
    parsed_content = JSON.parse(content)
    content_html = parsed_content["blocks"].map do |block|
      case block["type"]
      when "paragraph"
        paragraph_class = block["tunes"]["textVariant"] if block["tunes"].present?
        "<p class='paragraph--#{paragraph_class}'>#{block["data"]["text"]}</p>"
      when "header"
        "<h#{block["data"]["level"]}>#{block["data"]["text"]}</h#{block["data"]["level"]}>"
      when "list"
        list_items = block["data"]["items"].map { |item| "<li>#{item}</li>" }.join
        if block["data"]["style"] == "ordered"
          "<ol>#{list_items}</ol>"
        else
          "<ul>#{list_items}</ul>"
        end
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
      when "attaches"
        url = block["data"]["file"]["url"]
        name = block["data"]["title"] || block["data"]["file"]["name"]
        size = ::ApplicationController.helpers.number_to_human_size(block["data"]["file"]["size"])
        extension = block["data"]["file"]["extension"]

        file_html = <<-HTML
          <a href="#{url}" class="file-link">
            <div class="extension">
              #{extension}
            </div>
            <div class="flex-column">
              #{name}
              <span class="file-size">#{size}</span>
            </div>
          </a>
        HTML
      when "table"
        rows = block["data"]["content"].map.with_index { |row, index|
          tag = !!block["data"]["withHeadings"] && index == 0 ? "th" : "td"
          columns = row.map { |column| "<#{tag}>#{column}</#{tag}>" }
          "<tr>#{columns.join}</tr>"
        }

        if !!block["data"]["withHeadings"]
          thead = "<thead>#{rows.first}</thead>"
          tbody = "<tbody>#{rows[1..-1].join}</tbody>"
          table_content = "<table>#{thead}#{tbody}</table>"
        else
          table_content = "<table>#{rows.join}</table>"
        end

        table_content
      else
        ""
      end
    end
    content_html.join.html_safe
  end
end
