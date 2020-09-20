class AddModelToParsedDocument < ActiveRecord::Migration[5.2]
  def change
    add_column :parsed_documents, :model, :string
  end
end
