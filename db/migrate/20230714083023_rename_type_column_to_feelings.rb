class RenameTypeColumnToFeelings < ActiveRecord::Migration[6.1]
  def change
    rename_column :feelings, :type, :sort
  end
end
