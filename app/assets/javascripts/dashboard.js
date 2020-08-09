$(document).ready(function(){
  $(document.body).delegate('.js-create_new_template',        'click', showDocumentTemplateForm);
  $(document.body).delegate('.js-save_document_template',     'click', saveDocumentTemplate);
  $(document.body).delegate('.js-cancel_document_template',   'click', cancelSaveDocumentTemplate);
  $(document.body).delegate('.js-edit_document_template',     'click', editDocumentTemplate);
  $(document.body).delegate('.js-manage_template_questions',  'click', manageTemplateQuestions);
  $(document.body).delegate('.js-toggle_question_assignment', 'click', toggleQuestionAssignment);
  $(document.body).delegate('.js-create_new_question',        'click', showQuestionForm);
  $(document.body).delegate('.js-save_question',              'click', saveQuestion);
  $(document.body).delegate('.js-cancel_question',            'click', cancelSaveQuestion);
  $(document.body).delegate('.js-fill_out_template',          'click', showAnswerForm);
  $(document.body).delegate('.js-submit_document',            'click', saveDocument);
  $(document.body).delegate('.js-cancel_document',            'click', cancelDocument);
});

const showDocumentTemplateForm = () => {
  $('.js-document_template-form-ctn').removeClass('is-hidden');
};

const hideDocumentTemplateForm = () => {
  $('.js-document_template-form-ctn').addClass('is-hidden');
};

const saveDocumentTemplate = async () => {
  // TODO would add validation here

  const form     = document.querySelector('.js-document_template-form');
  const formData = new FormData(form);

  let url        = '/api/document_templates';
  let method     = 'POST';

  const templateId = formData.get('id');
  if(templateId){
    url    = `/api/document_templates/${templateId}`;
    method = 'PATCH';
  }

  const response = await fetch(url, {
    method: method,
    body: formData
  });

  const result = await response.json();
  if(result.success){
    refreshDocumentTemplateList();
    clearForm('.js-document_template-form');
    hideDocumentTemplateForm();
  }
};

const cancelSaveDocumentTemplate = () => {
  clearForm('.js-document_template-form');
  hideDocumentTemplateForm();
};

const refreshDocumentTemplateList = () => {
  $.ajax({
    url: '/api/document_templates.js',
    method: 'GET'
  });
};

const editDocumentTemplate = ev => {
  ev.preventDefault();

  const templateId = $(ev.currentTarget).closest('.js-document_template').data('id');
  $.ajax({
    url: `/api/document_templates/${templateId}/edit.js`,
    method: 'GET'
  });
};

const clearForm = (formSelector) => {
  $(formSelector).find(':input').not(':button, :submit, :reset, :hidden, :checkbox, :radio').val('');
  $(formSelector).find(':checkbox, :radio').prop('checked', false);
};

const manageTemplateQuestions = ev => {
  ev.preventDefault();

  const templateId = $(ev.currentTarget).closest('.js-document_template').data('id');
  showQuestionsForTemplate(templateId);
};

const showQuestionsForTemplate = templateId => {
  $.ajax({
    url: `/api/document_templates/${templateId}/show_questions.js`,
    method: 'GET'
  });
};

const toggleQuestionAssignment = async ev => {
  ev.preventDefault();

  const questionId         = $(ev.currentTarget).data('id');
  const action             = $(ev.currentTarget).data('action');
  const documentTemplateId = $(ev.currentTarget).closest('.js-question_management-form').data('template-id');

  const response = await fetch(`/api/questions/${questionId}/toggle_question_assignment`, {
    headers: {
      'Content-Type': 'application/json'
    },
    method: 'POST',
    body: JSON.stringify({ document_template_id: documentTemplateId, set_action: action })
  });

  const result = await response.json();
  if(result.success){
    showQuestionsForTemplate(documentTemplateId);
  }
};

const showQuestionForm = () => {
  $('.js-new_question-ctn').removeClass('is-hidden');
};

const hideQuestionForm = () => {
  $('.js-new_question-ctn').addClass('is-hidden');
};

const saveQuestion = async () => {
  // TODO would add validation here

  const form     = document.querySelector('.js-question-form');
  const formData = new FormData(form);

  let url        = '/api/questions';
  let method     = 'POST';

  const questionId = formData.get('id');
  if(questionId){
    url    = `/api/questions/${questionId}`;
    method = 'PATCH';
  }

  const response = await fetch(url, {
    method: method,
    body: formData
  });

  const result = await response.json();
  if(result.success){
    showQuestionsForTemplate(formData.get('document_template_id'));
    clearForm('.js-question-form');
    hideQuestionForm();
  }
};

const cancelSaveQuestion = () => {
  clearForm('.js-question-form');
  hideDocumentTemplateForm();
};

const showAnswerForm = ev => {
  ev.preventDefault();

  const templateId = $(ev.currentTarget).closest('.js-document_template').data('id');
  $.ajax({
    url: `/api/document_templates/${templateId}/show_answer_form.js`,
    method: 'GET'
  });
};

const saveDocument = async (ev) => {
  ev.preventDefault();
  // TODO would add validation here

  const form     = document.querySelector('.js-document-form');
  const formData = new FormData(form);

  const url        = '/api/documents';
  const method     = 'POST';

  const response = await fetch(url, {
    method: method,
    body: formData
  });

  const result = await response.json();
  if(result.success){
    clearForm('.js-document-form');
    downloadDocument(result.id);
    $('.js-answer_form-ctn').addClass('is-hidden');
  }
};

const downloadDocument = documentId => {
  const el  = document.createElement('a');
  el.target = '_blank';
  el.href   = `/api/documents/${documentId}/download`;
  el.click();
};

const cancelDocument = (ev) => {
  ev.preventDefault();
  clearForm('.js-document-form');
  $('.js-answer_form-ctn').addClass('is-hidden');
};