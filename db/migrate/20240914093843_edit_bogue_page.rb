class EditBoguePage < ActiveRecord::Migration[7.1]
  def change
    rename_table :bogue_pages, :pages
    add_reference :pages, :bogue
  end
end
