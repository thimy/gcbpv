class CreateSubbedWorkshops < ActiveRecord::Migration[7.1]
  def change
    create_table :subbed_workshops do |t|
      t.references :workshop, null: false, foreign_key: true
      t.references :subscription, null: false, foreign_key: true
      t.text :comment

      t.timestamps
    end

    remove_reference :subscriptions, :workshop
  end
end
