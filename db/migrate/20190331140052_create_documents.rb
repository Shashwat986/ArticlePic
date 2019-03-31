class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.text :text
      t.integer :author_id, index: true

      t.timestamps
    end
  end
end
