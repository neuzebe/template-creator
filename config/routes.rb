Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  namespace :api do
    resources :document_templates
    resources :questions
    resources :documents do
      member do
        post :finish
        post :answer_question
      end
    end
  end
end
