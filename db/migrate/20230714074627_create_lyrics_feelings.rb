class CreateLyricsFeelings < ActiveRecord::Migration[6.1]
  def change
    create_table :lyrics_feelings do |t|
      t.references :lyric, null: false, foreign_key: true
      t.references :feeling, null: false, foreign_key: true

      t.timestamps
    end
  end
end
