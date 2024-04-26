class Public::UsersController < ApplicationController
   before_action :authenticate_user!
   before_action :ensure_not_guest_user, only: [:destroy]

  def show
    @user = User.find(params[:id])
    @music_posts = @user.music_posts
    @new_music_post = MusicPost.new
    @favorite_niko = @user.nikos.where(is_favorite: true).first
  end

  # user検索用
  def index
    if params[:search]
      @users = User.where('nickname LIKE ?', "%#{params[:search]}%")
    else
      @users = User.all
    end

  end

  def edit
    @user = User.find(params[:id])
    @niko = Niko.new
  end

  def confirm
     @user = User.find(params[:id]) # または適切な方法でユーザーを取得
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  private

  def niko_tree_type_parame
    params.require(:niko_tree_type).permit(:tree_type)
  end

  # ゲストログイン縛りの設定
  def ensure_not_guest_user
    if current_user.guest_user?
      flash[:alert] = "ゲストユーザーはこの操作を実行できません。"
      redirect_to edit_user_path(current_user)
    end
  end

  def user_params
    params.require(:user).permit(:nickname, :introduction, :profile_image)
  end
end
