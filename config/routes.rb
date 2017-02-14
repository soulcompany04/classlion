Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  #비로그인 시 root
  root 'home#index'

  #메인
  get 'home/index'

  #회원가입, 로그인
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get 'sessions/new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  #인증 이메일 안내
  get '/signup/send_authMail/:e' => 'account_activations#authMail', :constraints => { :e => /.+@.+\..*/ }
  #인증 이메일 재전송
  get '/signup/resend_authMail' => 'account_activations#re_authMail' #안내 폼
  post '/signup/resend_authMail' => 'account_activations#resend_authMail' #실제 전송 프로세스

  #이메일, 닉네임 유무 체크 (jQuery)
  post '/check-nickname' => 'users#check_nickname'
  post '/check-email' => 'users#check_email'

  #강의 리스트(검색결과)
  get '/courses' => 'courses#index'
  #강의 세부정보 - 강의평가 모음
  get 'courses/show'
  get 'courses/show/:id' => 'courses#show'

  resources :evaluations do
    resources :comments
  end
  get '/main' => 'evaluations#main'
  get '/info' => 'evaluations#info'
  get 'evaluations/comment'
  resources :comments

  #마이페이지 - 열람권한 on/off, 작성한 강평리스트, 작성한 댓글리스트, 회원정보 수정 링크
  get 'mypage' => 'mypages#index'

  post 'roles/evaluator'
  post 'roles/wikier'
  post 'roles/lack'
  #테스트용
  post 'roles/remove'
  post 'roles/reset'
  post 'roles/charge'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
