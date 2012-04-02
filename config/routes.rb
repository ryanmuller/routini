Routini::Application.routes.draw do
  devise_for :users

  root :to => "tasks#index"
  match '/help' => 'pages#help'

  resources :tasks, :only => [ :create, :destroy, :index, :show, :edit, :update ] do
    resources :microtasks, :only => [ :create, :update ]
  end
  resources :logs, :only => [ :create ]
  resources :situations, :only => [ :create, :destroy, :show, :edit, :update ]

  match "/contexts/:id" => "situations#show"
end
