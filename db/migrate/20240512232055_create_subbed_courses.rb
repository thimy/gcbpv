class CreateSubbedCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :subbed_courses do |t|
      t.references :course, null: false, foreign_key: true
      t.references :subscription, null: false, foreign_key: true
      t.text :comment

      t.timestamps
    end

    remove_reference :subscriptions, :course
  end
end
