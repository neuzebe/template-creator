class Document < ApplicationRecord
  belongs_to :document_template
  has_many   :answers
  has_many   :questions, through: :document_template

  validates :document_template_id, presence: true

  enum status: {
    in_progress: 0,
    completed:   1
  }

  delegate :name, to: :document_template, allow_nil: true

  def finish
    # TODO - I would think about additional checks here to confirm all tags have been replaced.
    # Maybe the document is invalid unless completely filled
    doc = self
    str = doc.document_template.content

    doc.answers.includes(:question).find_each do |answer|
      str.gsub!("{{#{answer.question.tag}}}", answer.content)
    end

    doc.output = str
    doc.status = :completed

    doc.save
  end

  def download_name
    "#{name} - Download.pdf"
  end
end
