class CreateDocumentTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :document_templates do |t|
      t.string :name
      t.text   :description
      t.text   :content
      t.timestamps
    end
  end
end
