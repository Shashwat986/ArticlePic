class CreateKeywords < ActiveRecord::Migration[5.2]
  def change
    create_table :keywords do |t|
      t.string :keyword, index: true
      t.integer :image_id

      t.timestamps
    end
  end
end
