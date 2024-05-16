class DropSubbedCourses < ActiveRecord::Migration[7.1]
  def change
    drop_table :subbed_courses
    add_reference :courses, :subscription
  end
end
