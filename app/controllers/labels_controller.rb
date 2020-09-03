class LabelsController < ApplicationController
  def create
    label = current_user.labels.new(label_params)

    if label.save
      redirect_to tasks_path, notice: 'ラベルを作成しました。'
    else
      error_messages = if label.errors.any?
                         label.errors.full_messages.join('\n')
                       else
                         '不明な理由で、ラベルの作成に失敗しました。'
                       end
      redirect_to tasks_path, alert: error_messages
    end
  end

  def destroy; end

  private

  def label_params
    params.require(:label).permit(:name)
  end
end
