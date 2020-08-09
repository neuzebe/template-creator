$(document).ready(function(){
  $(document.body).delegate('.js-create_new_template',      'click', showDocumentTemplateForm);
  $(document.body).delegate('.js-save_document_template',   'click', saveDocumentTemplate);
  $(document.body).delegate('.js-cancel_document_template', 'click', cancelSaveDocumentTemplate);
});

const showDocumentTemplateForm = () => {
  $('.js-document_template-form-ctn').removeClass('is-hidden');
};

const saveDocumentTemplate = async () => {
  // TODO would add validation here

  const form     = document.querySelector('.js-document_template-form');
  const formData = new FormData(form);

  let url        = '/api/document_templates';
  let method     = 'POST';

  const response = await fetch(url, {
    method: method,
    body: formData
  });

  const result = await response.json();
  if(result.success){
    refreshDocumentTemplateList();
    form.reset();
  }
};

const cancelSaveDocumentTemplate = (ev) => {
  $(ev.currentTarget).closest('form')[0].reset();
  $('.js-document_template-form-ctn').addClass('is-hidden');
};

const refreshDocumentTemplateList = () => {
  $.ajax({
    url: '/api/document_templates.js',
    method: 'GET'
  });
};