class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @my_labels = current_user.labels
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result.includes(:labels).page(params[:page]).order(created_at: :desc)
  end

  def show; end

  def new
    @task = current_user.tasks.new
  end

  def edit; end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to @task, notice: 'タスクを作成しました。'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      flash.notice = 'タスクを編集しました。'
      # editページからupdateの場合はtask_pathに返す、それ以外は元のページに戻る
      if URI.parse(request.headers['Referer']).path == edit_task_path(@task)
        redirect_to @task
      else
        redirect_back fallback_location: @task
      end
    else
      render :edit
    end
  end

  def destroy
    if @task.destroy
      redirect_to tasks_path, notice: 'タスクを削除しました。'
    else
      redirect_to tasks_path, alert: 'タスクの削除に失敗しました。'
    end
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :end_date, :status, :priority)
  end
end
