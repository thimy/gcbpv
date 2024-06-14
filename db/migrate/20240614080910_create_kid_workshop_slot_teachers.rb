class CreateKidWorkshopSlotTeachers < ActiveRecord::Migration[7.1]
  def change
    create_table :kid_workshop_slot_teachers do |t|
      t.belongs_to :teacher, null: false, foreign_key: true
      t.belongs_to :kid_workshop_slot, null: false, foreign_key: true

      t.timestamps
    end

    add_reference :subscriptions, :kid_workshop_slot
    add_column    :kid_workshops, :price, :decimal
    add_column    :kid_workshop_slots, :status, :integer
    add_column    :cities, :status, :integer
    add_column    :editions, :status, :integer
    add_column    :events, :status, :integer
    add_column    :instruments, :status, :integer
    add_column    :projects, :status, :integer
    remove_column :projects, :public
    add_column    :trainings, :status, :integer
    add_column    :training_sessions, :status, :integer
    add_column    :workshop_slots, :status, :integer
    add_column    :workshops, :status, :integer
    remove_column :workshops, :archived
  end
end
