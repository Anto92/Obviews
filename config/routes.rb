Rails.application.routes.draw do

  get 'users/show'
  get 'users/carousel', to: 'users#carousel'
  get 'users/ranking' , to: 'users#ranking'

  root 'board#show'

  get 'board/show'
  post 'board/show'

  get 'board/new'

  get 'board/index', to: 'board#index'

  get 'board/create', to: 'board#create'

  get 'board/share', to: 'board#share'
  get 'board/confirmation', to: 'board#confirmation'
  post '/users/show'
  devise_for :users, controllers: {
           :sessions => "users/sessions",
           :registrations => "users/registrations" }



  get 'match/index', to: 'match#index'
  get 'match/show', to: 'match#show'

  get 'users/show', to: 'users#show'

  post 'board/confirmation'

  get 'board/next', to: 'board#next', as: 'next'
  get 'board/match', to: 'board#match', as: 'match'
  get 'randomizers/reset', to: 'randomizers#reset'
  get 'board/fb_share', as: 'board_fb_share'
  get 'users/fb_share', as: 'users_fb_share'
end
