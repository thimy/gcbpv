class PostEventReferenceNull < ActiveRecord::Migration[7.1]
  def change
    remove_reference :posts, :event
    add_reference :posts, :event, null: true
  end
end
