require 'rails_helper'

RSpec.describe Poll, type: :model do
  describe 'attributes' do
    it { is_expected.to respond_to :poll_description }
  end

  describe 'associations' do
    it { is_expected.to have_many(:poll_options) }
    it { is_expected.to have_many(:poll_views) }

    it { is_expected.to accept_nested_attributes_for(:poll_options) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:poll_description) }
  end

  describe 'methods' do
    describe '#views' do
      let(:poll) { create(:poll) }
      let!(:poll_views) { create_list(:poll_view, 3, poll: poll) }

      it { expect(poll.views).to eq 3 }
    end

    describe '#increment_views' do
      let(:poll) { create(:poll) }

      before { poll.increment_views }

      it { expect(poll.views).to eq 1 }
      it { expect(PollView.count).to eq 1 }
    end
  end
end
