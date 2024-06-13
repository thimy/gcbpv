class AlterWorkshops < ActiveRecord::Migration[7.1]
  def change
    remove_reference :workshops, :city
    remove_column    :workshops, :frequency
    remove_column    :workshops, :day_of_week
    remove_column    :workshops, :start_time
    remove_column    :workshops, :end_time
    add_column       :workshops, :archived, :integer
  end
end
