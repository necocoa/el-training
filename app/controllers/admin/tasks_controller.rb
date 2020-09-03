class Admin::TasksController < ApplicationController
  before_action :admin_required

  def index
    @q = User.find(params[:user_id]).tasks.ransack(params[:q])
    @tasks = @q.result.page(params[:page]).order(created_at: :desc)
  end
end
