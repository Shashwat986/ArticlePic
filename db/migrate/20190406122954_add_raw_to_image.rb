class AddRawToImage < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :raw, :text
    add_index :images, [:source, :uuid]
  end
end
