class CreateCustomWorkshopSlots < ActiveRecord::Migration[7.1]
  def change
    add_column :workshop_slots, :is_custom, :boolean
  end
end
