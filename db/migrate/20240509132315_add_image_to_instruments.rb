class AddImageToInstruments < ActiveRecord::Migration[7.1]
  def change
    add_column :instruments, :image, :string
  end
end
