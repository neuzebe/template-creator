class Api::DocumentTemplatesController < ActionController::API

  def create
    document = DocumentTemplate.create params.require(:document_template).permit(:name, :description, :content)

    render json: { success: document.id.present?, id: document.id }
  end
end