class UsersController < ApplicationController

  around_action LoggingAction.new, only: [:new, :create]
  # ログインなしでアクセス可能な画面を定義(ユーザ作成画面表示と作成処理) 
  skip_before_action :require_sign_in!, only: [:new, :create]
    
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # xxx_path => GET /xxx を生成 
      redirect_to login_path
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :mail, :password, :password_confirmation)
    end

end
