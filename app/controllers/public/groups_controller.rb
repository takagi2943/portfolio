class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]


  def index
    @group = Group.new # 新しくグループ作成
    @groups = Group.all
    @music_posts = MusicPost.new
    @user = current_user
  end

  def show
    @music_posts = MusicPost.new
    @group = Group.find(params[:id])
    @user = @group.owner
  end

  def create
    @group = Group.new(group_params)
    @group.user_id = current_user.id
    if @group.save
      redirect_to user_groups_path
    else
      render :index
    end
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'グループ情報が更新されました。'
    else
      render :edit
    end
  end
  private

  def group_params
    params.require(:group).permit(:name, :bod, :image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end
