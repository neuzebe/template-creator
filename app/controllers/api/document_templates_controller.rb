class Api::DocumentTemplatesController < ActionController::API
  include ActionController::MimeResponds

  before_action :find_document_template, only: [:edit, :update, :show_questions, :show_answer_form]

  def index
    @document_templates = DocumentTemplate.all

    respond_to do |format|
      format.js { render  'document_templates/index' }
    end
  end

  def edit
    respond_to do |format|
      format.js { render  'document_templates/edit' }
    end
  end

  def create
    document = DocumentTemplate.create params.require(:document_template).permit(:name, :description, :content)

    render json: { success: document.id.present?, id: document.id }
  end

  def update
    success = @document_template.update_attributes params.require(:document_template).permit(:name, :description, :content)

    render json: { success: success }
  end

  def show_questions
    @questions = Question.all

    respond_to do |format|
      format.js { render  'document_templates/show_questions' }
    end
  end

  def show_answer_form
    @questions = @document_template.questions.to_a

    respond_to do |format|
      format.js { render  'document_templates/show_answer_form' }
    end
  end

  private

  def find_document_template
    @document_template = DocumentTemplate.find_by_id params[:id]
  end
end