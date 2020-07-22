Rails.application.routes.draw do
  root "pages#home"
  resources :articles, only: %i[show index]
end
