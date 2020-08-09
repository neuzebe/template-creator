class Answer < ApplicationRecord
  belongs_to :question, required: true
  belongs_to :document, required: true

  validates :content, presence: true
end
