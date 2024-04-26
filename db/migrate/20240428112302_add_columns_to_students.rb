class AddColumnsToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :street, :string
    add_column :students, :zip_code, :string
    add_column :students, :city, :string
    add_column :students, :birth_year, :integer
  end
end
