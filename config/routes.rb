Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  resources :books,only:[:index, :show, :edit, :create, :update, :destroy]
  resources :users,only:[:index, :edit, :update, :show, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
