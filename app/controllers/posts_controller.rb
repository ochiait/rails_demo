class PostsController < ApplicationController
  before_action :signed_in?
  # 初期表示
  def index
    @posts = Post.all.recent.page(params[:page]).per(5)
  end
  # データを閲覧する画面を表示するためのAction
  def show
    @post = Post.find(params[:id])
  end
  # データを作成する画面を表示するためのAction
  def new
    @post = Post.new
  end
  # データを更新する画面を表示するためのAction
  def edit
    @post = Post.find(params[:id])
    # 自身の投稿かどうか
    unless is_mine?(@post)
      redirect_to @post and return
    end
  end
  # データを作成するためのAction
  def create
    @post = Post.new(post_params)
    @post.user_id = current_social_account.user_id
    @post.save
    redirect_to @post
  end
  # データを更新するためのAction
  def update
    @post = Post.find(params[:id])
    # 自身の投稿かどうか
    unless is_mine?(@post)
      redirect_to @post and return
    end
    @post.update_attributes(post_params)
    redirect_to @post
  end
  # データを削除するためのAction
  def destroy
    @post = Post.find(params[:id])
    # 自身の投稿かどうか
    unless is_mine?(@post)
      redirect_to @post and return
    end
    @post.destroy
    redirect_to posts_path
  end
  
  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
  
  # ログイン判定
  def signed_in?
    unless social_account_signed_in?
      redirect_to root_path and return
    end
  end
  
  # 自身の投稿かどうかを判定
  def is_mine?(post)
    post.user_id == current_social_account.user_id
  end
end
