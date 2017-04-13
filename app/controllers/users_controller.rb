class UsersController < ApplicationController
  before_action :goto_main, only: [:new]
  before_action :logged_in_user, only: [:edit, :update, :favorites_add, :favorites_delete]
  # before_action :correct_user,   only: [:edit, :update]

  # def show
  #   # 마이페이지로 대처? 고민해볼 것
  #   @user = User.find(params[:id])
  # end

  def new
    # 회원가입 form
    #redirect_to '/main' if @current_user && @current_user.activated? #이미 로그인한 상태고, 이메일인증 된 경우 main페이지로 리다렉트
    @user = User.new
  end

  def create
    # 회원가입 process
    @user = User.new(user_params)

    if @user.save
      @user.send_activation_email
      # redirect_to "/signup/send_authMail/#{user.email}" #이메일 인증 안내 페이지로
      # session[:user_id] = user.id #세션생성
      log_in @user
      # render text: session[:user_id].email
      redirect_to '/signup/send_authMail' #세션이 있는 상태에서 리다이렉트
    else
      render action: "new"
    end
  end

  def edit
    # 회원정보 수정 form
    #@user = User.find(params[:id])
    @user = @current_user
  end

  def update
    # 회원정보 수정 process
    @user = @current_user
    if @user.update_attributes(user_params)
    # 업데이트 성공시
      flash[:success] = "변경 완료!"
    else
      flash[:warning] = "어머나, 문제가 생겼어요!"
      render 'edit'
    end
  end

  # 닉네임 중복검사
  def check_nickname
    nickname = params[:nickname]
    user = User.where('nickname = ?', nickname).first
    if user.present? #있으면
      render json: { msg: "overlap" }
    else #없으면
      render json: { msg: "ok" }
    end
  end

  # 이메일 중복검사
  def check_email
    email = params[:email]
    user = User.where('email = ?', email).first
    if user.present? #있으면
      render json: { msg: "overlap" }
    else #없으면
      render json: { msg: "ok" }
    end 
  end

  # 관심강의 추가/제거
  def favorites_add
    if @current_user.favorites_addition(@current_user.id, params[:c_id].to_i)
      render json: { msg: "ok"}
    else
      render json: { msg: "error"}
    end
  end

  def favorites_delete
    if @current_user.favorites_deletion(@current_user.id, params[:c_id].to_i)
      render json: { msg: "ok"}
    else
      render json: { msg: "error"}
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :nickname, :is_boy, :university_id,
                                 :password, :password_confirmation)
  end

  # Before filters

  # Confirms a logged-in user.
  #application_controller.rb에 정의

  # Confirms the correct user.
  # def correct_user
  #   @user = User.find(params[:id])
  #   redirect_to(root_url) unless current_user?(@user)
  # end
end