class CreateEmails < ActiveRecord::Migration[7.1]
  def change
    create_table :emails do |t|
      t.string :subject
      t.string :recipients
      t.jsonb :content
      t.datetime :sent_at

      t.timestamps
    end
  end
end
