require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe 'index' do
    it 'タスクが作成日の降順で表示される' do
      old_task = create(:task, name: '古いタスク')
      new_task = create(:task, name: '新しいタスク')
      old_task.update(name: '古いタスクを更新') # 更新しても順番が変わらないことを確認するため

      visit tasks_path
      tasks = all('.task_list')
      expect(tasks[0]).to have_content new_task.name
      expect(tasks[1]).to have_content old_task.name
    end
  end

  describe 'show' do
    let!(:task) { create(:task) }
    it 'タスクが表示される' do
      visit task_path(task)
      expect(page).to have_content task.name
    end
  end

  describe 'create' do
    it 'タスクが作成され、作成されたタスクが表示される' do
      visit new_task_path

      fill_in 'task[name]', with: 'Task name'
      fill_in 'task[description]', with: 'Task description'
      click_button :commit

      expect(page).to have_content 'タスクを作成しました。'
      expect(page).to have_content 'Task name'
      expect(page).to have_content 'Task description'
    end
    context '名前を入力していない時' do
      it 'エラーメッセージが表示される' do
        visit new_task_path

        fill_in 'task[description]', with: 'Task description'
        click_button :commit

        expect(page).to have_content 'Nameを入力してください'
      end
    end
  end

  describe 'update' do
    let(:task) { create(:task) }
    let(:update_task_name) { 'Change task name' }
    it 'タスクを編集し、編集したタスクが表示される' do
      visit edit_task_path(task)

      expect(page).to have_field 'task[name]', with: task.name
      expect(page).to have_field 'task[description]', with: task.description

      fill_in 'task[name]', with: update_task_name
      click_button :commit

      expect(current_path).to eq task_path(task)
      expect(page).to have_content 'タスクを編集しました。'
      expect(page).to have_content update_task_name
      expect(page).to have_content task.description
    end
  end

  describe 'destroy', js: true do
    let(:task) { create(:task) }
    it 'タスクを削除する' do
      visit task_path(task)

      page.accept_confirm('タスクを削除しますか？') { click_on :task_delete }

      expect(current_path).to eq tasks_path
      expect(page).to have_content 'タスクを削除しました。'
    end
  end
end
