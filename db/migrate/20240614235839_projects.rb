class Projects < ActiveRecord::Migration[7.1]
  def change
    remove_reference :projects, :season
    add_column :project_instances, :description, :text
    add_column :project_instances, :comment, :text
    add_column :project_instances, :status, :integer
  end
end
