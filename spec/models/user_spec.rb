require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validate' do
    let(:user) { build(:user) }
    it { expect(user).to be_valid }
  end

  describe 'callback' do
    describe '管理者の削除' do
      let!(:admin_user) { create(:user, admin: true) }
      context '管理者が1人の時' do
        it '管理者を削除できない' do
          expect(User.where(admin: true).count).to eq 1
          expect { admin_user.destroy! }.to raise_error(ActiveRecord::RecordNotDestroyed)
        end
      end
      context '管理者が2人以上の時' do
        let!(:second_admin_user) { create(:user, admin: true) }
        it '管理者を削除できる' do
          expect(User.where(admin: true).size).to be > 1
          expect { second_admin_user.destroy! }.to change { User.count }.by(-1)
        end
      end
    end
  end
end
