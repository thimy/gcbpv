class MergeWorkshopSlots < ActiveRecord::Migration[7.1]
  def change
    add_column :workshops, :is_youth, :boolean
    add_column :workshops, :kid_workshop_type, :integer
  end
end
