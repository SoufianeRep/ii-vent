Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "/dashboard", to: "users#dashboard", as: :dashboard
  resources :events, only: [:new, :create, :show] do
    resources :members, only: [:create]
    resources :tasks, only: [:new, :create]
    resources :messages, only: [:index, :create]
  end

  resources :tasks, only: [:update, :edit] do
    resources :task_members, only: [:new, :create]
  end
end
