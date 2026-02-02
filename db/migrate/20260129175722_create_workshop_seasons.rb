class CreateWorkshopSeasons < ActiveRecord::Migration[7.1]
  def change
    create_table :workshop_seasons do |t|
      t.references :season, null: false, foreign_key: true
      t.references :workshop, null: false, foreign_key: true

      t.timestamps
    end
    create_table :instrument_seasons do |t|
      t.references :season, null: false, foreign_key: true
      t.references :instrument, null: false, foreign_key: true

      t.timestamps
    end
    create_table :workshop_slot_seasons do |t|
      t.references :season, null: false, foreign_key: true
      t.references :workshop_slot, null: false, foreign_key: true

      t.timestamps
    end
    create_table :slot_seasons do |t|
      t.references :season, null: false, foreign_key: true
      t.references :slot, null: false, foreign_key: true

      t.timestamps
    end
    create_table :teacher_seasons do |t|
      t.references :season, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
