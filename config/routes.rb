Rails.application.routes.draw do
  devise_for :admins,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :members
    resources :comments
  end

  devise_scope :member do
    post 'members/guest_sign_in', to: 'members/sessions#guest_sign_in'
  end
  devise_for :members,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }


  scope module: :public do
    root to: 'homes#top'
    get "homes/about" => "homes#about"
    resources :tasks do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    get 'search' => 'searches#search'

    get 'members/unsubscribe' => 'members#unsubscribe'
    delete 'members/withdraw' => 'members#withdraw'
    resources :members, only: [:show, :edit, :update] do
      member do
        get "favorites"
      end
    end
  end


end
