class CreateJoinTableDocumentImage < ActiveRecord::Migration[5.2]
  def change
    create_join_table :documents, :images do |t|
      t.index [:document_id, :image_id]
      t.index [:image_id, :document_id]
    end
  end
end
