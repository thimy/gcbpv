class AddEventReference < ActiveRecord::Migration[7.1]
  def change
    add_reference :events, :event
  end
end
