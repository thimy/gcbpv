class CreateEmails < ActiveRecord::Migration[7.1]
  def change
    create_table :emails do |t|
      t.string :subject
      t.string :recipients
      t.text :body
      t.integer :status

      t.timestamps
    end
  end
end
