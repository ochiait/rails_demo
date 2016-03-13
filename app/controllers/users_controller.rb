class UsersController < ApplicationController
  before_action :signed_in?
  # 初期表示
  def index
    users = User.all
    # パラメータとして名前か性別を受け取っている場合は絞って検索する
    if params[:name].present?
      users = users.get_by_name params[:name]
    end
    if params[:gender].present?
      users = users.get_by_gender params[:gender]
    end
    
    @users = users.page(params[:page]).per(5)
  end
  # データを閲覧する画面を表示するためのAction
  def show
    @user = User.find(params[:id])
  end
  # データを作成する画面を表示するためのAction
  def new
    @user = User.new
  end
  # データを更新する画面を表示するためのAction
  def edit
    @user = User.find(params[:id])
  end
  # データを作成するためのAction
  def create
    @user = User.new(user_params)
    @user.save
    redirect_to @user
  end
  # データを更新するためのAction
  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    redirect_to @user
  end
  # データを削除するためのAction
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end
  
  def user_params
    params.require(:user).permit(:name, :gender, :birthday, :hometown, :remarks, :image)
  end
  
  # ログイン判定
  def signed_in?
    unless social_account_signed_in?
      redirect_to root_path and return
    end
  end
end
