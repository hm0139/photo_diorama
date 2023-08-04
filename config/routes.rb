Rails.application.routes.draw do
  devise_for :users
  root to: "commissions#index"
  resources :commissions, only:[:index, :new, :create, :show] do
    member do
      get "select"
      get "selected_confirmation"
      patch "direct"
      get "unsuccessful"
    end
    collection do
      get "search"
    end
    resources :dealings, only:[:new, :create, :show, :destroy]
    resources :chats, only:[:create]
  end

  resources :notifications, only:[:index, :destroy]
  
  resources :creators, only:[:index] do
    collection do
      get "search"
    end
  end
  resources :users, only:[:show] do
    resources :achievements, only:[:new, :create ,:edit ,:update]
  end
end
