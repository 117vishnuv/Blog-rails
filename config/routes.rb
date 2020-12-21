Rails.application.routes.draw do
  resources :categories
  devise_for :users
  resources :articles do
    resources :comments
  end
  get 'welcome/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  # root 'articles#index'
  get 'search', to: 'articles#search', :as => 'search_article' 
end
