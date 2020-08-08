require 'rails_helper'

describe 'Document', type: :request do

  describe 'creating a new document' do
    context 'with valid template id' do
      before(:each) do
        @template = FactoryBot.create(:document_template)
      end

      it 'should create new empty document' do
        expect{
          post '/api/documents', params: { document: { document_template_id: @template.id }}
        }.to change(Document, :count).by(1)

        res = JSON.parse response.body
        doc = Document.last

        expect(res['success']).to eq true
        expect(res['id']).to eq doc.id
        expect(doc.output).to be_nil
        expect(doc.status).to eq 'in_progress'
        expect(doc.document_template_id).to eq @template.id
      end
    end
  end

  describe 'creating answer for question in document ' do
    before(:each) do
      @template  = FactoryBot.create(:document_template)
      @question  = FactoryBot.create(:question)

      @question.document_template_questions.create document_template_id: @template.id
      @document = FactoryBot.create(:document, document_template_id: @template.id)
    end

    context 'with valid question and document inputs' do
      it 'should create an answer' do
        expect{
          post "/api/documents/#{@document.id}/answer_question", params: { answer: { question_id: @question.id, content: 'answer text' } }
        }.to change(Answer, :count).by(1)

        res = JSON.parse response.body
        ans = Answer.last

        expect(res['success']).to eq true
        expect(ans.question_id).to eq @question.id
        expect(ans.document_id).to eq @document.id
        expect(ans.content).to eq 'answer text'
      end
    end
  end

  describe 'generating output on document' do
    before(:each) do
      @template  = FactoryBot.create(:document_template, content: 'Document Content. This will serve the purpose of {{reason}}. To be submitted to {{destination}}')

      @question  = FactoryBot.create(:question, tag: 'reason')
      @question.document_template_questions.create document_template_id: @template.id

      @question2 = FactoryBot.create(:question, tag: 'destination')
      @question2.document_template_questions.create document_template_id: @template.id

      @document  = FactoryBot.create(:document, document_template_id: @template.id)
    end

    context 'with all questions answered' do
      before(:each) do
        FactoryBot.create(:answer, document_id: @document.id, question_id: @question.id, content: 'reason answer')
        FactoryBot.create(:answer, document_id: @document.id, question_id: @question2.id, content: 'destination answer')
      end

      it 'should finish document and generate output' do
        expect{
          post "/api/documents/#{@document.id}/finish"
          @document.reload
        }.to change(@document, :status).from('in_progress').to('completed')

        res = JSON.parse response.body

        expect(res['success']).to eq true
        expect(@document.reload.output).to eq 'Document Content. This will serve the purpose of reason answer. To be submitted to destination answer'
      end
    end
  end


end