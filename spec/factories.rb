FactoryBot.define do
  factory :document_template do
    name        { 'Document Name' }
    description { 'Document Description' }
    content     { 'Document Content. This will serve the purpose of {{reason}}. To be submitted to {{destination}}' }
  end
end