class Api::QuestionsController < ActionController::API

  def create
    success  = false
    question = Question.create params.require(:question).permit(:content, :tag)
    success  = question.assign_document_templates(params[:document_template_id]) if question.id

    render json: { success: success, id: question.id }
  end

  def toggle_question_assignment
    question = Question.find_by_id params[:id]

    success = if params[:set_action] == 'assign'
                obj = DocumentTemplateQuestion.find_or_create_by question_id: question.id, document_template_id: params[:document_template_id]
                obj.id.present?
              else
                DocumentTemplateQuestion.where(question_id: question.id, document_template_id: params[:document_template_id]).destroy_all
                true
              end

    render json: { success: success }
  end
end