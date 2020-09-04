require 'rails_helper'

RSpec.describe TaskLabel, type: :model do
  describe 'validate' do
    let(:task_label) { build(:task_label) }
    it { expect(task_label).to be_valid }
  end

  context '同じラベルを2個以上付けた時' do
    let(:user) { create(:user) }
    let(:task) { create(:task, user: user) }
    let(:label) { create(:label, user: user) }
    let(:first_task_label) { build(:task_label, task: task, label: label) }
    let(:second_task_label) { build(:task_label, task: task, label: label) }
    it '失敗する' do
      first_task_label.save!
      expect(second_task_label).to be_invalid
      expect(second_task_label.errors.full_messages).to include 'ラベルはすでに存在します'
    end
  end
end
