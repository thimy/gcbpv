class CreateEmailImages < ActiveRecord::Migration[7.1]
  def change
    create_table :email_images do |t|
      t.belongs_to :email, foreign_key: true

      t.timestamps
    end
  end
end
