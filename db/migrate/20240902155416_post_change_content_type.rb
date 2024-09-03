class PostChangeContentType < ActiveRecord::Migration[7.1]
  def change
    drop_table :posts do |t|
    end
    create_table :posts do |t|
      t.string :title
      t.jsonb :content
      t.datetime :sent_at
      t.belongs_to :event
      t.integer :status
      t.datetime "published_at"

      t.timestamps
    end
  end
end
