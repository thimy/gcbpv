class AddSecondaryPhoneAndEmail < ActiveRecord::Migration[7.1]
  def change
    add_column :payors, :secondary_phone, :string
    add_column :payors, :secondary_email, :string
  end
end
