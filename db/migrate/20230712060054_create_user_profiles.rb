class CreateUserProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_profiles do |t|
      t.string :name, null: false, default: '名前未登録'
      t.text :icon
      t.string :image_cache
      t.text :introduction
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
