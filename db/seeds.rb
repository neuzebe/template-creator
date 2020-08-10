# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# @template  = FactoryBot.create(:document_template, content: 'Document Content. This will serve the purpose of {{reason}}. To be submitted to {{destination}}')
#
# @question  = FactoryBot.create(:question, tag: 'reason')
# @question.document_template_questions.create document_template_id: @template.id
#
# @question2 = FactoryBot.create(:question, tag: 'destination')
# @question2.document_template_questions.create document_template_id: @template.id
#
# @document  = FactoryBot.create(:document, document_template_id: @template.id)