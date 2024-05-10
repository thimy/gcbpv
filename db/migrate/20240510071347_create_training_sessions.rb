class CreateTrainingSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :training_sessions do |t|
      t.string :name
      t.text :description
      t.string :guest
      t.references :training, null: false, foreign_key: true
      t.date :date
      t.string :start_time
      t.string :end_time
      t.string :city
      t.text :image

      t.timestamps
    end
  end
end
