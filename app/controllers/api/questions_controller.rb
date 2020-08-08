class Api::QuestionsController < ActionController::API

  def create
    success  = false
    question = Question.create params.require(:question).permit(:content, :tag)
    success  = question.assign_document_templates(params[:document_template_ids]) if question.id

    render json: { success: success, id: question.id }
  end
end