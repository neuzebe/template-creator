class DocumentTemplateQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :document_template

  validates :question_id          , presence: true
  validates :document_template_id , presence: true, uniqueness: { scope: [:question_id] }
end
