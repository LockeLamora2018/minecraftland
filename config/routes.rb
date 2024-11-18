Rails.application.routes.draw do
  devise_for :users
  root 'articles#index' #defini que toda vez que o local host for acessado, a action articles#index será acionada

  resources :articles do
    resources :comments, only: %i[create destroy]
  end

  resources :categories, except: [:show]
end
