class CreateLyrics < ActiveRecord::Migration[6.1]
  def change
    create_table :lyrics do |t|
      t.string :phrase, null: false
      t.string :detail, null: false

      t.timestamps
    end
  end
end
