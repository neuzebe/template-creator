class Api::DocumentsController < ActionController::API
  before_action :find_document, only: [:finish, :answer_question]

  def create
    template  = DocumentTemplate.find_by_id params[:document_template_id]
    document  = Document.create document_template_id: template.id
    questions = template.questions

    params[:answer].each do |tag, answer|
      question = questions.select{|q| q.tag == tag}.first
      Answer.create(question_id: question.id, document_id: document.id, content: answer)
    end

    document.finish

    render json: { success: document.id.present?, id: document.id }
  end

  def finish
    success = @document.finish

    render json: { success: success }
  end

  def download
    document = Document.find_by_id params[:id]

    Prawn::Document.generate(document.download_name) do
      text document.name, align: :center, size: 18
      move_down 20
      text document.output
    end

    file    = File.open(document.download_name, 'r')
    content = file.read

    File.delete(document.download_name)

    send_data content, filename: document.download_name, type: :pdf
  end

  def answer_question
    answer = Answer.new params.require(:answer).permit(:content, :question_id)
    answer.document_id = @document.id
    answer.save

    render json: { success: answer.id.present?, id: answer.id }
  end

  private

  def find_document
    @document = Document.find_by_id params[:id]
    unless @document
      render json: { success: false } and return
    end
  end
end