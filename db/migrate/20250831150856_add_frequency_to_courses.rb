class AddFrequencyToCourses < ActiveRecord::Migration[7.1]
  def change
    add_column :courses, :frequency, :integer
  end
end
