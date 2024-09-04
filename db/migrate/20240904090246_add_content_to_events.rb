class AddContentToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :content, :jsonb
  end
end
