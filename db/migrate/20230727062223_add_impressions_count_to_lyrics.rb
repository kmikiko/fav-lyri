class AddImpressionsCountToLyrics < ActiveRecord::Migration[6.1]
  def change
    add_column :lyrics, :impressions_count, :integer, default: 0
  end
end
