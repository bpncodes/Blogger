class CreateCsvFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :csv_files do |t|
      t.string :name, null: false
      t.binary :data, null: false
      t.string :mime_type

      t.timestamps
    end
  end
end
