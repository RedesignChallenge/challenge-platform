require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web, at: 'sidekiq'
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end

  devise_for :users, controllers: { registrations: 'registrations' }
  
  root to: 'home#index'

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

    resources :approach_stages, only: [:show] do
      resources :approach_ideas, only: [:show] do
        resources :approaches do
          member do
            put :like, :unlike
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

  match 'preview', to: 'home#preview', via: 'get'

  match 'about', to: 'static_pages#about', via: 'get'
  match 'contact', to: 'static_pages#contact', via: 'get'
  match 'research', to: 'static_pages#research', via: 'get'
  match 'privacy', to: 'static_pages#privacy', via: 'get'
  match 'terms', to: 'static_pages#terms', via: 'get'
  match 'bcg_report', to: 'static_pages#bcg_report', via: 'get'

  match 'states/search', to: 'states#search', via: 'get'
  match 'districts/search', to: 'districts#search', via: 'get'
  match 'schools/search', to: 'schools#search', via: 'get'

  ## FIXES FOR ALPHA NAME CHANGE ISSUES (REMOVE AFTER A WHILE)
  get '/challenges/:challenge_id/ideation_stages(*all)', to: redirect("/challenges/%{challenge_id}/idea_stages%{all}")
  ## FIXES FOR ALPHA NAME CHANGE ISSUES (REMOVE AFTER A WHILE)
end