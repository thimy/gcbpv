module ApplicationHelper
  include Pagy::Frontend

  def dynamic_fields_for f, association, name = "Ajouter"
    # stimulus:      controller v
    tag.div data: {controller: "dynamic-fields"} do
      safe_join([
        # render existing fields
        f.fields_for(association) do |ff|
          yield ff
        end,

        # render "Add" button that will call `add()` function
        # stimulus:         `add(event)` v
        button_tag(name, data: {action: "dynamic-fields#add"}),

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
    list.map { |element| element.subscription.email }.join(", ")
  end
end
