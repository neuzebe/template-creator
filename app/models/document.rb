class Document < ApplicationRecord
  belongs_to :document_template
  has_many   :answers
  has_many   :questions, through: :document_template

  validates :document_template_id, presence: true

  enum status: {
    in_progress: 0,
    completed:   1
  }

  def finish
    doc = self
    str = doc.document_template.content

    doc.answers.includes(:question).find_each do |answer|
      str.gsub!("{{#{answer.question.tag}}}", answer.content)
    end

    doc.output = str
    doc.status = :completed

    doc.save
  end
end
