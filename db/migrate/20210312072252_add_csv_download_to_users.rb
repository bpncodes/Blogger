class AddCsvDownloadToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :csv_download, :boolean
  end
end
