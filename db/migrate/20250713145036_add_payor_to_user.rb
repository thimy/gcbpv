class AddPayorToUser < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :teacher
  end
end
