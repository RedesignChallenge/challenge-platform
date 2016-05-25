require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web, at: 'sidekiq'
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end

  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: [:show]
  
  root to: 'home#index'
  match 'preview',          to: 'home#preview',         via: :get
  match 'about',            to: 'home#about',           via: :get
  match 'privacy',          to: 'home#privacy',         via: :get
  match 'terms',            to: 'home#terms',           via: :get

  match 'states/search',    to: 'states#search',        via: :get
  match 'districts/search', to: 'districts#search',     via: :get
  match 'schools/search',   to: 'schools#search',       via: :get

  resources :challenges, only: [:show, :index] do
    resources :experience_stages, only: [:show] do
      resources :themes, only: [:show] do
        resources :experiences do
          member do
            put :like, :unlike
          end
        end
      end
    end

    resources :idea_stages, only: [:show] do
      resources :problem_statements, only: [:show] do
        resources :ideas do
          member do
            put :like, :unlike
          end
        end
      end
    end

    resources :recipe_stages, only: [:show] do
      resources :cookbooks, only: [:show] do
        resources :recipes do
          member do
            put :like, :unlike, :try, :untry
          end
        end
      end
    end

    resources :solution_stages, only: [:show] do
      resources :solution_stories, only: [:show] do
        resources :solutions do
          member do
            put :like, :unlike
            get :file
          end
        end
      end
    end
  end

  resources :comments do
    member do
      put :like, :unlike
    end
  end

  resources :suggestions do
    member do
      put :like, :unlike
    end
  end
end