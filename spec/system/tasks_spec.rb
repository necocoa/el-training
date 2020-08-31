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

    it 'タスクを終了期限でソートできる' do
      slow_end_date_task = create(:task, name: '期限が遅いタスク', end_date: '2020-02-01')
      early_end_date_task = create(:task, name: '期限が早いタスク', end_date: '2020-01-01')

      visit tasks_path

      # ソートリンクを押すと初回は降順でソートされる
      click_link Task.human_attribute_name(:end_date)
      tasks = all('.task_list')
      expect(tasks[0]).to have_content early_end_date_task.name

      # ソートリンクを押すと2回目は昇順でソートされる
      click_link Task.human_attribute_name(:end_date)
      tasks = all('.task_list')
      expect(tasks[0]).to have_content slow_end_date_task.name
    end

    it 'タスク名で検索できる' do
      non_target_task = create(:task, name: '対象外のタスク')
      target_task = create(:task, name: '検索対象のタスク')

      visit tasks_path

      # 検索前はどちらも表示
      tasks = all('.task_list')
      expect(tasks[0]).to have_content target_task.name
      expect(tasks[1]).to have_content non_target_task.name

      # タスクを入力して検索
      fill_in 'q[name_cont]', with: target_task.name
      within find_by_id('task_search') do
        click_button :commit
      end

      # 検索結果に検索対象のタスクがあり、対象外はない
      tasks = all('.task_list')
      expect(tasks[0]).to have_content target_task.name
      expect(tasks[1]).not_to have_content non_target_task.name
    end

    it 'ステータスで検索できる' do
      non_target_task = create(:task, name: '対象外のタスク')
      target_task = create(:task, name: '検索対象のタスク', status: 'in_start')

      visit tasks_path

      # 検索前はどちらも表示
      tasks = all('.task_list')
      expect(tasks[0]).to have_content target_task.name
      expect(tasks[1]).to have_content non_target_task.name

      # ステータス着手中にチェックを入れ検索
      check 'q_status_in_1'
      within find_by_id('task_search') do
        click_button :commit
      end

      # 検索結果に検索対象のタスクがあり、対象外はない
      tasks = all('.task_list')
      expect(tasks[0]).to have_content target_task.name
      expect(tasks[1]).not_to have_content non_target_task.name
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

        expect(page).to have_content 'タスク名を入力してください'
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
