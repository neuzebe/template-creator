class CreateDocumentTemplateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :document_template_questions do |t|
      t.integer :document_template_id
      t.integer :question_id
      t.timestamps
    end
  end
end
