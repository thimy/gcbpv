class AddPayorAndStudentToUser < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :payor
    add_reference :users, :student
  end
end
