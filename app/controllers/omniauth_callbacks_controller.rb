class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    
    @account = SocialAccount.find_for_google_oauth2(request.env["omniauth.auth"])

    if @account.present?
      # ユーザーをサインイン状態にする
      sign_in(:social_account, @account)
      # 自分の詳細情報ページに遷移する
      redirect_to user_path(@account.user)
    # 認証失敗時
    else
      redirect_to root_path
    end
  end
end
