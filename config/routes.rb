Rails.application.routes.draw do
  resources :course_mappings do
    member do
      get :enroll
    end
  end

  resources :courses
  #get 'admin/index'

  #get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  resources :users
  get 'admin' => 'admin#index'
  controller :sessions do
  	get 'login' => :new
  	post 'login' => :create
  	delete 'logout' => :destroy
  end

  controller :courses do
    get 'addcourse' => :new
    post 'addcourse' => :create
    delete 'deletecourse' => :destroy
  end
  #root 'admin#index'
  root 'users#current_user_home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
