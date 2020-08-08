class DocumentTemplate < ApplicationRecord

  has_many :document_template_questions
  has_many :questions, through: :document_template_questions

  validates :name   , presence: true
  validates :content, presence: true
end
