class CreateAttachments < ActiveRecord::Migration[7.1]
  def change
    create_table :attachments do |t|
      t.belongs_to :attachable, polymorphic: true
      t.string :name
      t.string :extension
      t.float :size

      t.timestamps
    end
  end
end
