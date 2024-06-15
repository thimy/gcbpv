class Pathways < ActiveRecord::Migration[7.1]
  def change
    add_column :pathways, :status, :integer
    add_column :pathway_slots, :status, :integer
    add_column :payors, :comment, :text
    add_column :plans, :pathway_price, :decimal
    remove_column :plans, :adult_discovery_price
    remove_column :plans, :fourth_step_discount
    remove_column :plans, :fourth_step
    add_column :projects, :comment, :text
    add_column :subscriptions, :comment, :text
    remove_column :subscriptions, :paid_amount
    add_column :teachers, :comment, :text
    add_column :training_sessions, :comment, :text
    add_column :trainings, :comment, :text
    add_column :workshop_slots, :comment, :text
    add_column :workshops, :comment, :text

    create_table :project_instances do |t|
      t.belongs_to :project, null: false, foreign_key: true
      t.belongs_to :season, null: false, foreign_key: true
      
      t.timestamps
    end

    create_table :project_students do |t|
      t.belongs_to :project_instance, null: false, foreign_key: true
      t.belongs_to :student, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
