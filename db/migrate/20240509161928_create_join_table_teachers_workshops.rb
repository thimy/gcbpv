class CreateJoinTableTeachersWorkshops < ActiveRecord::Migration[7.1]
  def change
    create_table :teachers_workshops do |t|
      t.references :teacher
      t.references :workshop
    end
  end
end
