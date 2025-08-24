class AddEmtToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :is_emt, :boolean
  end
end
