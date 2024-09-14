class ChangeEventReference < ActiveRecord::Migration[7.1]
  def change
    remove_reference :events, :event
    add_reference :events, :parent_event
  end
end
