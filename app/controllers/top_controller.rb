class TopController < ApplicationController
  def index
  end
  def profile
    @user_name = "レイルズ"
    @birthday  = "1987/6/10"
    @hometown  = "滋賀県"
    @skills    = ["プログラミング", "詩の朗読", "ものまね"]
    @remarks   = "よろしくお願いいたします"
    @gender    = "man"
  end
end
