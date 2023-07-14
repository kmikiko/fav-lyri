class ChangeColumnsAddNotnullOnSongs < ActiveRecord::Migration[6.1]
  def change
    change_column_null :songs, :title, false
  end
end
