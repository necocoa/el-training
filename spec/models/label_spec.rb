require 'rails_helper'

RSpec.describe Label, type: :model do
  describe 'validate' do
    let(:label) { build(:label) }
    it { expect(label).to be_valid }

    context '同じラベル名を2つ作ったとき' do
      let(:user) { create(:user) }
      let(:first_label) { build(:label, name: '同じラベル', user: user) }
      let(:second_label) { build(:label, name: '同じラベル', user: user) }
      it '失敗する' do
        first_label.save!
        expect(second_label).to be_invalid
        expect(second_label.errors.full_messages).to include 'ラベルはすでに存在します'
      end
    end
  end
end
