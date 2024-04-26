class AddPayorToStudents < ActiveRecord::Migration[7.1]
  def change
    add_reference :students, :payor
  end
end
