class Admin::UsersController < ApplicationController
  before_action :admin_required
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.join_tasks_count.page(params[:page]).order(created_at: :desc)
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_user_path(@user), notice: 'ユーザーを作成しました。'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: 'ユーザーを編集しました。'
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: 'ユーザーを削除しました。'
    else
      error_messages = if @user.errors.any?
                         @user.errors.full_messages.join('\n')
                       else
                         '不明な理由で、ユーザーの削除に失敗しました。'
                       end
      redirect_to admin_users_path, alert: error_messages
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end
end
