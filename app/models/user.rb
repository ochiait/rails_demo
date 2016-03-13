# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string
#  gender             :integer
#  birthday           :date
#  hometown           :string
#  remarks            :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class User < ActiveRecord::Base
  enum gender: { unknown: 0, male: 1, female: 2, other: 9 }
  
  has_one :social_account
  
  # ユーザー名による絞り込み
  scope :get_by_name, ->(name) {
    where("name like ?", "%#{name}%")
  }
  # 性別による絞り込み
  scope :get_by_gender, ->(gender) {
    where(gender: gender)
  }
  # 画像の保存設定
  has_attached_file :image,
    styles: { medium: "300x300>", thumb: "200x200>" },
    path: "#{Rails.root}/public/system/:class/image/:id.:style.:extension",
    url: "/system/:class/image/:id.:style.:extension"

  validates_attachment_content_type :image, content_type: /image/
  
end
