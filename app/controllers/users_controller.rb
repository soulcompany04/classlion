class UsersController < ApplicationController

  skip_before_action :session_check, :only => ["new", "create", "check_nickname", "check_email"]

  def show
    #마이페이지로 대처? 고민해볼 것
    @user = User.find(params[:id])
  end

  def new
    #회원가입 form
    @user = User.new
  end

  def create
    #회원가입 process
    user = User.new(user_params)

    if user.save
      user.send_activation_email
      redirect_to "/signup/send_authMail/#{user.email}" #이메일 인증 안내 페이지로
    else
      render action: "new"
    end
  end

  def edit
    #회원정보 수정 form
    @user = @current_user
  end

  def update
    #회원정보 수정 process
    @user = @current_user
    if @user.update_attributes(user_params)
    #업데이트 성공시
      flash[:success] = "변경 완료!"
    else
      flash[:warning] = "어머나, 문제가 생겼어요!"
      render 'edit'
    end
  end

  #닉네임 중복검사
  def check_nickname
    nickname = params[:nickname]
    user = User.where('nickname = ?', nickname).first
    if user.present? #있으면
      render json: { msg: "overlap" }
    else #없으면
      render json: { msg: "ok" }
    end
  end

  #이메일 중복검사
  def check_email
    email = params[:email]
    user = User.where('email = ?', email).first
    if user.present? #있으면
      render json: { msg: "overlap" }
    else #없으면
      render json: { msg: "ok" }
    end 
  end

  def favorites_add
    if @current_user.favorites_addition(params[:u_id].to_i, params[:c_id].to_i)
      redirect_to :back
    end
  end

  def favorites_delete
    if @current_user.favorites_addition(params[:u_id].to_i, params[:c_id].to_i)
      redirect_to :back
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :nickname, :is_boy, :university_id,
                                 :password, :password_confirmation)
  end
end
