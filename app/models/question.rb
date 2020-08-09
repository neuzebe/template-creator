class Question < ApplicationRecord
  has_many :document_template_questions
  has_many :document_templates, through: :document_template_questions

  def assign_document_templates(document_template_id)
    obj     = DocumentTemplateQuestion.find_or_create_by question_id: self.id, document_template_id: document_template_id
    obj.id.present?
  end
end
