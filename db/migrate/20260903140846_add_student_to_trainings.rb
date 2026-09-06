class AddStudentToTrainings < ActiveRecord::Migration[8.1]
  def change
    create_table :training_students do |t|
      t.references :training_session, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
    end
    add_column :training_sessions, :price, :decimal
  end
end
