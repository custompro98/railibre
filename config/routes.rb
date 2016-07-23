Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books, only: [:index, :show]

  root 'books#index'

  get 'download/:id', to: 'files#download', as: 'download'
end
