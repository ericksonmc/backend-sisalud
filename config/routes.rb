# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      devise_for :users, defaults: { format: :json }, controllers: {
        sessions: 'api/v1/users/sessions'
      }
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/session', to: 'session#index'
      namespace :users do
        resources :users
      end
      resources :products, only: %i[index update show]
      resources :plans, only: %i[index update create]
      resources :diseases, only: %i[index]
      resources :agreements do
        post :authorize_agreement
        post :update_agreement
      end
      resources :customers, only: [:index, :show] do
        get :filter_customer, on: :collection
        get :customer_scales_limit
        get :eventualities
      end
      resources :miscelaneos, only: [] do
        get :states, on: :collection
        get :municipalities, on: :collection
        get :sections, on: :collection
      end
      resources :attachments, only: [:create]
      resources :scales, except: [:destroy] do
        get :types_scale, on: :collection
        get :scale_usage, on: :collection
      end
      resources :eventualities, except: [:destroy] do
        post :eventuality_invoice
      end
      resources :dashboard, only: [:index]
    end
  end
end
