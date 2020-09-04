class LabelsController < ApplicationController
  def index
    @labels = current_user.labels
  end

  def create
    label = current_user.labels.new(label_params)

    if label.save
      redirect_back fallback_location: tasks_path, notice: 'ラベルを作成しました。'
    else
      error_messages = if label.errors.any?
                         label.errors.full_messages.join('\n')
                       else
                         '不明な理由で、ラベルの作成に失敗しました。'
                       end
      redirect_back fallback_location: tasks_path, alert: error_messages
    end
  end

  def destroy
    label = current_user.labels.find(params[:id])
    if label.destroy
      redirect_back fallback_location: tasks_path, notice: 'ラベルを削除しました。'
    else
      redirect_back fallback_location: tasks_path, alert: 'ラベルの削除に失敗しました。'
    end
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end
end
