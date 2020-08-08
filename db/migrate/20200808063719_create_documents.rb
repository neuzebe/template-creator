class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.integer :document_template_id
      t.integer :status, default: 0
      t.text :output
      t.timestamps
    end
  end
end
