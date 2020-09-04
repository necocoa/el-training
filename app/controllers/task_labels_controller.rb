class TaskLabelsController < ApplicationController
  before_action :set_task, only: %i[create destroy]

  def create
    task_label = @task.task_labels.new(task_label_params)

    if task_label.save
      redirect_back fallback_location: tasks_path, notice: 'ラベルを付けました。'
    else
      error_messages = if task_label.errors.any?
                         task_label.errors.full_messages.join('\n')
                       else
                         '不明な理由で、ラベルの添付に失敗しました。'
                       end
      redirect_back fallback_location: tasks_path, alert: error_messages
    end
  end

  def destroy
    task_label = @task.task_labels.find(params[:id])
    if task_label.destroy
      redirect_back fallback_location: root_path, notice: 'ラベルを外しました。'
    else
      redirect_back fallback_location: tasks_path, alert: 'ラベルの削除に失敗しました。'
    end
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def task_label_params
    params.require(:task_label).permit(:label_id)
  end
end
