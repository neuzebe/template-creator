class Question < ApplicationRecord
  has_many :document_template_questions
  has_many :document_templates, through: :document_template_questions

  validates :content, presence: true
  validates :tag    , presence: true

  validate :validate_tag_format

  def assign_document_templates(document_template_id)
    obj = DocumentTemplateQuestion.find_or_create_by question_id: self.id, document_template_id: document_template_id
    obj.id.present?
  end

  private

  def validate_tag_format
    if self.tag&.match(/[^a-z_]/)
      self.errors.add(:tag, 'is invalid. Only a-z and _ are allowed')
    end
  end
end
