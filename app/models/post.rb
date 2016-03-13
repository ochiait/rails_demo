# == Schema Information
#
# Table name: posts
#
#  id                 :integer          not null, primary key
#  title              :string
#  body               :text
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Post < ActiveRecord::Base
  
  validates :title, presence: true
  validates :body, presence: true
  
  belongs_to :user
  
  # 日付順
  scope :recent, -> {
    order('posts.created_at desc')
  }
  
  # 画像の保存設定
  has_attached_file :image,
    styles: { medium: "300x300>", thumb: "200x200>" },
    path: "#{Rails.root}/public/system/:class/image/:id.:style.:extension",
    url: "/system/:class/image/:id.:style.:extension"

  validates_attachment_content_type :image, content_type: /image/
end
