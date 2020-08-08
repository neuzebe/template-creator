FactoryBot.define do
  factory :answer

  factory :document

  factory :document_template do
    name        { 'Document Name' }
    description { 'Document Description' }
    content     { 'Document Content. This will serve the purpose of {{reason}}. To be submitted to {{destination}}' }
  end

  factory :question do
    content {'What is the reason of this document?' }
    tag     {'reason' }
  end
end