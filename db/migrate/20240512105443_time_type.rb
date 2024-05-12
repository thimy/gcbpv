class TimeType < ActiveRecord::Migration[7.1]
  def change
    add_column :teachers, :status, :integer
  end
end
