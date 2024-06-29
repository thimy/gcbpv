class AddSubbedPathways < ActiveRecord::Migration[7.1]
  def change
    create_table :subbed_pathways do |t|
      t.references :pathway_slot, null: false, foreign_key: true
      t.references :subscription, null: false, foreign_key: true
      t.text :comment

      t.timestamps
    end

    add_column :courses, :comment, :text
    add_column :courses, :option, :integer
    add_column :subbed_workshops, :option, :integer
    add_column :subscription_groups, :status, :integer
    add_column :subscription_groups, :majoration_class, :integer
    add_column :workshops, :max_students, :integer
    add_column :students, :comment, :text
    add_column :slots, :comment, :text
    add_column :plans, :comment, :text
    add_column :pathways, :comment, :text
    add_column :kid_workshops, :comment, :text
    add_column :kid_workshop_slots, :comment, :text
    add_column :instruments, :comment, :text
    add_column :events, :comment, :text
    add_column :editions, :comment, :text
    add_column :cities, :comment, :text
  end
end
