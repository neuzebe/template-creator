require 'rails_helper'

describe 'Document', type: :request do

  describe 'creating a new document' do
    context 'with valid template id' do
      before(:each) do
        @template  = FactoryBot.create(:document_template, content: 'Document Content. This will serve the purpose of {{reason}}. To be submitted to {{destination}}')

        @question  = FactoryBot.create(:question, tag: 'reason')
        @question.document_template_questions.create document_template_id: @template.id

        @question2 = FactoryBot.create(:question, tag: 'destination')
        @question2.document_template_questions.create document_template_id: @template.id
      end

      it 'should create new empty document' do
        expect{
          post '/api/documents', params: { document_template_id: @template.id, answer: valid_answer_data(@template) }
        }.to change(Document, :count).by(1)
         .and change(Answer, :count).by(2)

        res = JSON.parse response.body
        doc = Document.last

        expect(res['success']).to eq true
        expect(res['id']).to eq doc.id
        expect(doc.output).to eq 'Document Content. This will serve the purpose of reason answer. To be submitted to destination answer'
        expect(doc.status).to eq 'completed'
        expect(doc.document_template_id).to eq @template.id
      end
    end
  end

end

def valid_answer_data(doc_template)
  resp = {}

  doc_template.questions.each do |question|
    resp[question.tag] = "#{question.tag} answer"
  end

  resp
end