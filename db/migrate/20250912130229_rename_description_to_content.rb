class RenameDescriptionToContent < ActiveRecord::Migration[7.1]
  def change
    rename_column :projects, :description, :content
    remove_reference :projects, :end_year
    remove_reference :projects, :start_year
    add_reference :projects, :season
  end
end
