class AddColumnsToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :organizer, :string
    add_column :events, :website, :string
    remove_column :events, :city
  end
end
