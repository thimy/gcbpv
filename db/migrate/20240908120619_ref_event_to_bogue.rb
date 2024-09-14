class RefEventToBogue < ActiveRecord::Migration[7.1]
  def change
    add_reference :events, :bogue
    add_column :events, :event_type, :integer
    add_column :events, :slug, :string
    add_column :events, :highlight, :boolean
  end
end
