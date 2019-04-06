class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :url
      t.string :url_small
      t.string :url_other

      t.string :source
      t.string :uuid

      t.string :keywords
      t.string :description

      t.integer :width
      t.integer :height


      t.timestamps
    end
  end
end
