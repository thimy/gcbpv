class RenameTrainingDescriptionToContent < ActiveRecord::Migration[7.1]
  def change
    rename_column :trainings, :description, :content
    rename_column :training_sessions, :description, :content
    add_column :training_sessions, :location, :string
  end
end
