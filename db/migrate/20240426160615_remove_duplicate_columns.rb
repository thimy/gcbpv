class RemoveDuplicateColumns < ActiveRecord::Migration[7.1]
  def change
    remove_reference :teachers, :instrument
  end
end
