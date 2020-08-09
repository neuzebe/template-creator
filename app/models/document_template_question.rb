class DocumentTemplateQuestion < ApplicationRecord
  belongs_to :question          , required: true
  belongs_to :document_template , required: true

  validates :question_id          , presence: true
  validates :document_template_id , presence: true, uniqueness: { scope: [:question_id] }

  validate :validate_no_duplicate_tags

  delegate :tag, to: :question

  private

  def validate_no_duplicate_tags
    question_ids_with_tag = Question.where(tag: self.tag).where.not(id: self.question_id).pluck(:id)
    if DocumentTemplateQuestion.where(question_id: question_ids_with_tag).exists?
      self.errors.add(:question, 'would create duplicate tags on document template')
    end
  end
end
