Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "/dashboard", to: "users#dashboard", as: :dashboard
  get "/calendar", to: "users#calendar", as: :calendar
  resources :events, only: [:new, :create, :show] do
    resources :event_members, only: [:create]
    resources :tasks, only: [:new, :create] do
      resources :tasks, only: [:create]
    end
    resources :messages, only: [:show, :create]
  end

  resources :tasks, only: [:update, :edit] do
    resources :task_members, only: [:new, :create]
  end
end
