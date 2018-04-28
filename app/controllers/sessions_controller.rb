class SessionsController < ApplicationController
  # before_action :require_sign_in!, only: [:destroy]
  before_action :set_user, only: [:create]
  around_action LoggingAction.new, only: [:new, :create]

  def new
  end

  def create

    # autenticateはモデルでhas_secure_passwordを宣言していると自動的に使用できるようになる
    if @user.authenticate(session_params[:password])
      sign_in(@user)
      redirect_to diaries_path
    else
      # flash.now[:danger] = t('.flash.invalid_password')
      flash.now[:danger] = "パスワード違うで。[#{session_params[:mail]}]"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to login_path
  end

  private

    def set_user
      @user = User.find_by!(mail: session_params[:mail])
    rescue
      # flash.now[:danger] = t('.flash.invalid_mail')
      flash.now[:danger] = "そんなゆーざおらんで。[#{session_params[:mail]}]"
      render action: 'new'
    end

    # 許可するパラメータ
    def session_params
      params.permit(:mail, :password)
    end

end
