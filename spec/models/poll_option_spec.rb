require 'rails_helper'

RSpec.describe PollOption, type: :model do
  describe 'attributes' do
    it { is_expected.to respond_to(:option_description) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:poll) }

    it { is_expected.to have_many(:poll_option_votes) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:option_description) }
  end

  describe 'methods' do
    let(:poll_option) { create(:poll_option, poll: create(:poll)) }

    describe '#qty' do
      context 'without any votes' do
        it { expect(poll_option.qty).to eq 0 }
      end

      context 'with votes' do
        before { create_list(:poll_option_vote, 3, poll_option: poll_option) }

        it { expect(poll_option.qty).to eq 3 }
      end
    end

    describe '#vote' do
      before { poll_option.vote }

      it { expect(poll_option.poll_option_votes.count).to eq 1 }
    end
  end
end
