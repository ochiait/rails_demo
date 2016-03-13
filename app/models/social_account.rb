# == Schema Information
#
# Table name: social_accounts
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :integer
#  provider               :string
#  uid                    :string
#  name                   :string
#  token                  :string
#

class SocialAccount < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  
  # ユーザー情報に紐づく
  belongs_to :user
  
  # Google認証結果を取得
  def self.find_for_google_oauth2(auth)
    account = SocialAccount.where(email: auth.info.email).first
 
    unless account
      # ユーザー情報を作成する
      user = User.create(name: auth.info.name)
      # アカウント情報を作成する
      account = SocialAccount.create(name: auth.info.name,
                         user_id:  user.id,
                         provider: auth.provider,
                         uid:      auth.uid,
                         email:    auth.info.email,
                         token:    auth.credentials.token,
                         password: Devise.friendly_token[0, 20])
    end
    account
  end
end
