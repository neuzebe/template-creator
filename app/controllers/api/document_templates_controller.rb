class Api::DocumentTemplatesController < ActionController::API
  include ActionController::MimeResponds

  def index
    @document_templates = DocumentTemplate.all

    respond_to do |format|
      format.js { render  'document_templates/index' }
    end
  end

  def create
    document = DocumentTemplate.create params.require(:document_template).permit(:name, :description, :content)

    render json: { success: document.id.present?, id: document.id }
  end
end