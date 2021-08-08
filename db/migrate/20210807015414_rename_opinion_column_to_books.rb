class RenameOpinionColumnToBooks < ActiveRecord::Migration[5.2]
  def change
    rename_column :Books, :opinion, :body
  end
end
