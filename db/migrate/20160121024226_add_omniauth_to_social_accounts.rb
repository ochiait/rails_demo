class AddOmniauthToSocialAccounts < ActiveRecord::Migration
  def change
    add_column :social_accounts, :user_id, :integer
    add_column :social_accounts, :provider, :string
    add_column :social_accounts, :uid, :string
    add_column :social_accounts, :name, :string
    add_column :social_accounts, :token, :string
  end
end
