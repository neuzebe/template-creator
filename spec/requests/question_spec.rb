require 'rails_helper'

describe 'Questions', type: :request do
  describe 'creating a question and assigning to document(s)' do
    before(:each) do
      @document_template = FactoryBot.create(:document_template)
    end

    context 'with valid inputs' do
      it 'should create a new question and assign it to document' do
        expect{
          post '/api/questions', params: { question: valid_question_params, document_template_ids: [@document_template.id] }
        }.to change(Question, :count).by(1)

        question = Question.last
        res      = JSON.parse response.body

        expect(res['success']).to eq true
        expect(question.document_templates.count).to eq 1
        expect(question.document_templates.first.id).to eq @document_template.id
      end
    end
  end
end

def valid_question_params
  {
    content: 'What is the reason of this document?',
    tag:      'reason'
  }
end