require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validate' do
    let(:task) { build(:task) }
    it { expect(task).to be_valid }

    describe 'is invalid' do
      context 'when name' do
        it 'is nil' do
          task.name = nil
          expect(task).not_to be_valid
        end
        it 'is 0 char' do
          task.name = ''
          expect(task).not_to be_valid
        end
        it 'is over 50 char' do
          task.name = 'a' * 51
          expect(task).not_to be_valid
        end
      end
      context 'when description' do
        it 'is over 1000 char' do
          task.description = 'a' * 1001
          expect(task).not_to be_valid
        end
      end
    end
  end
end
