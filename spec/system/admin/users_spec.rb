require 'rails_helper'

RSpec.describe 'Users', type: :system do
  context 'ノンログイン状態' do
    it 'ログイン画面に遷移する' do
      visit admin_users_path
      expect(current_path).to eq login_path
    end
  end

  context 'ログイン状態' do
    let(:test_user) { create(:user) }
    before do
      # ログイン
      visit login_path
      fill_in 'session[email]',	with: test_user.email
      fill_in 'session[password]',	with: test_user.password
      click_button :commit
    end

    describe 'index' do
      it 'ユーザーが作成日降順で表示される' do
        old_user = create(:user, name: '古いユーザー')
        new_user = create(:user, name: '古いユーザー')
        old_user.update(name: '古いユーザーを更新')

        visit admin_users_path
        users = all('.user_list')
        expect(users[0]).to have_content new_user.name
        expect(users[1]).to have_content old_user.name
      end

      it 'タスク数が表示される' do
        create(:task, user: test_user)
        visit admin_users_path
        tasks_count = find_by_id('tasks_count')
        expect(tasks_count.text).to eq test_user.tasks.size.to_s
      end
    end

    describe 'show' do
      it 'ユーザーが表示される' do
        visit admin_user_path(test_user)
        expect(page).to have_content test_user.name
      end
    end

    describe 'create' do
      it 'ユーザーが作成できる' do
        visit new_admin_user_path
        fill_in 'user[name]', with: 'user name'
        fill_in 'user[email]', with: 'user@example.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'

        expect do
          click_button :commit
          expect(page).to have_content 'ユーザーを作成しました。'
          expect(page).to have_content 'user name'
        end.to change { User.count }.by(1)
      end
    end

    describe 'update' do
      let(:update_user_name) { 'Change user name' }
      it 'ユーザーが編集できる' do
        visit edit_admin_user_path(test_user)
        expect(page).to have_field 'user[name]', with: test_user.name
        fill_in 'user[name]', with: update_user_name
        fill_in 'user[password]', with: test_user.password
        fill_in 'user[password_confirmation]', with: test_user.password
        click_button :commit

        expect(page).to have_content 'ユーザーを編集しました。'
        expect(page).to have_content update_user_name
      end
    end
    describe 'destroy' do
      context 'ユーザーページから削除する時', js: true do
        let(:target_user) { create(:user) }
        it 'ユーザーを削除できる' do
          visit admin_user_path(target_user)
          expect do
            page.accept_confirm('ユーザーを削除しますか？') { click_on :user_delete }
            expect(current_path).to eq admin_users_path
            expect(page).to have_content 'ユーザーを削除しました。'
          end.to change { User.count }.by(-1)
        end

        it '関連タスクもすべて削除される' do
          create(:task, user: target_user)
          visit admin_user_path(target_user)
          page.accept_confirm('ユーザーを削除しますか？') { click_on :user_delete }
          visit current_path
          expect(target_user.tasks.count).to eq 0
        end
      end
    end
  end
end
