require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  def do_login
    visit login_path
    fill_in 'session[email]',	with: current_user.email
    fill_in 'session[password]',	with: current_user.password
    click_button :commit
  end

  let(:current_user) { create(:user) }
  describe 'new' do
    it 'ログイン画面が表示される' do
      visit login_path
      expect(page).to have_content User.human_attribute_name(:email)
      expect(page).to have_content User.human_attribute_name(:password)
    end
  end

  describe 'create' do
    it 'ログインできる' do
      do_login
      expect(current_path).to eq root_path
    end
  end

  describe 'destroy' do
    it 'ログアウトできる' do
      do_login
      delete logout_path(current_user)
      expect(session[:user_id]).to be nil
    end
  end

  context 'ログイン時' do
    it 'ログアウトリンクが表示される' do
      do_login
      expect(page).to have_content 'ログアウト'
    end
  end

  context 'ノンログイン時' do
    it 'ログインリンクが表示される' do
      visit root_path
      expect(page).to have_content 'ログイン'
    end
  end
end
