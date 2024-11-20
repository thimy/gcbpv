class RenameStudentColumns < ActiveRecord::Migration[7.1]
  def change
    rename_column :students, :street, :address
    rename_column :students, :zip_code, :postcode
  end
end
