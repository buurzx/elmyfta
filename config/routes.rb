# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    passwords:     'users/passwords',
    sessions:      'users/sessions'
  }

  get 'catalogs'  => 'pages#catalogs'
  get 'agreement' => 'pages#agreement'
  get 'privacy'   => 'pages#privacy'

  resource  :products,      only: :edit
  resources :products,      only: %i[show new create]

  resources :organizations, only: %i[edit update show]

  resources :users,         only: [:update]

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  get '*unmatched_route', to: 'application#page_not_found'
end
