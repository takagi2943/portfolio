class LaboComment < ApplicationRecord
  
  # タグ探究室とユーザーの紐づけ
  belongs_to :user
  belongs_to :labo

  # コメントの設定
  validates :comments, presence: true, length: { maximum: 200 }

end
