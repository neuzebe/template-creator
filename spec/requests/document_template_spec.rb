require 'rails_helper'

describe 'Document Template', type: :request do
  describe 'creating a template' do

    context 'with valid inputs' do
      it 'should create a new document template' do
        expect {
          post '/api/document_templates', params: { document_template: valid_document_template_params }
        }.to change(DocumentTemplate, :count).by(1)

        template = DocumentTemplate.last
        res      = JSON.parse response.body

        expect(res['success']).to eq true
        expect(res['id']).to eq template.id

        expect(template.name).to eq valid_document_template_params[:name]
        expect(template.content).to eq valid_document_template_params[:content]
      end
    end

    context 'with invalid inputs' do
      it 'should return success false'
    end
  end
end

def valid_document_template_params
  {
    name:        'Document Name',
    description: 'Document Description',
    content:     'Document Content. This will serve the purpose of {{reason}}. To be submitted to {{destination}}'
  }
end