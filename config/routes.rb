Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/' => 'dashboard#index'

  namespace :api do
    resources :document_templates do
      member do
        get  :show_questions
        get  :show_answer_form
      end
    end

    resources :questions do
      member do
        post :toggle_question_assignment
      end
    end

    resources :documents do
      member do
        get  :download
      end
    end
  end
end
