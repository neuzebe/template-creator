class Api::DocumentsController < ActionController::API
  before_action :find_document, only: [:finish, :answer_question]

  def create
    document = Document.create params.require(:document).permit(:document_template_id)

    render json: { success: document.id.present?, id: document.id }
  end

  def finish
    success = @document.finish

    p @document

    render json: { success: success }
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