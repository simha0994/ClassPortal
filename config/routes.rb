Rails.application.routes.draw do
  resources :materials
  resources :course_mappings do
    collection do
      get 'show_requests' => :show_requests
      get 'accept_requests' => :accept_requests
      get 'reject_requests' => :reject_requests
      get 'show_courses' => :show_courses
      get 'show_enrolled_students' => :show_enrolled_students
      get 'remove_students' => :remove_students
    end
    member do
      get :enroll
      get :grades
    end
  end

  resources :courses do
    collection do
      #get 'show_enrolled_students' => :show_enrolled_students
      get 'show_instructor_courses' => :show_instructor_courses
    end
    member do
      get 'show_enrolled_students' => :show_enrolled_students
    end
  end

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
