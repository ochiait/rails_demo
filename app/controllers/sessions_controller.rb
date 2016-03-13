class SessionsController < Devise::SessionsController
  def new
    redirect_to root_path
  end

  # ログアウト
  def destroy
    super
    session[:keep_signed_out] = true
  end
end
