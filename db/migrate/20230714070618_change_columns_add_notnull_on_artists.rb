class ChangeColumnsAddNotnullOnArtists < ActiveRecord::Migration[6.1]
  def change
    change_column_null :artists, :name, false
  end
end
