Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books, only: [:index, :show]

  root 'books#index'

  get  'files',        to: 'files#index',    as: 'book_upload'
  post 'upload',       to: 'files#upload',   as: 'upload'
  get  'download/:id', to: 'files#download', as: 'download'
end
