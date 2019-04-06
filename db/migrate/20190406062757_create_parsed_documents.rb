class CreateParsedDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :parsed_documents do |t|
      t.integer :document_id, index: true
      t.text :keywords

      t.timestamps
    end
  end
end
