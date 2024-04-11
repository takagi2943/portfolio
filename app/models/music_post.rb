class MusicPost < ApplicationRecord

  # ユーザーと紐づけ
  belongs_to :user
  
  # 投稿画像
  has_one_attached :music_post_image
  # タイトルと投稿文設定
  validates :title, presence: true
	validates :body, presence: true, length: { maximum: 200 }

  # タイトル検索機能
  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%' + content)
    else
      Book.where('title LIKE ?', '%' + content + '%')
    end
  end

  # 画像を選択していたら表示させ選択されてなかったら表示させない
  def get_music_post_image
    if music_post_image.attached?
      music_post_image
    else
      nil
    end
  end

end
