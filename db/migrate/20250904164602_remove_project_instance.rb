class RemoveProjectInstance < ActiveRecord::Migration[7.1]
  def change
    remove_reference :project_students, :project_instance
    add_reference :project_students, :project
    add_reference :projects, :start_year
    add_reference :projects, :end_year
    add_foreign_key :projects, :seasons, column: :start_year_id, primary_key: :id
    add_foreign_key :projects, :seasons, column: :end_year_id, primary_key: :id
    drop_table :project_instances
  end
end
