require 'rails_helper'

RSpec.describe "Polls", type: :request do
  subject(:response_body) { JSON.parse(response.body) }

  describe 'GET /poll/:id' do
    context 'when record exists' do
      let(:poll_options) { build_list(:poll_option, 3) }
      let!(:poll) { create(:poll, poll_options: poll_options )}

      before { get "/poll/#{poll.id}" }

      it { expect(response).to be_successful}
      it { expect(response.status).to eq 200 }

      it { expect(response_body['poll_id']).to eq poll.id }
      it { expect(response_body['poll_description']).to eq poll.poll_description }

      it { expect(response_body['options'].size).to eq 3 }
      it { expect(response_body['options'].first.has_key?('option_id')).to be true }
      it { expect(response_body['options'].first.has_key?('option_description')).to be true }

      it { expect(poll.views).to eq 1 }
    end

    context 'when record doesn\'t exist' do
      before do
        allow(Poll).to receive(:find_by).and_return nil
        get '/poll/1'
      end

      it { expect(response).not_to be_successful }
      it { expect(response.status).to eq 404 }
      it { expect(response_body['status']).to eq 'not found' }
    end
  end

  describe 'GET /poll/:id/stats' do
    let(:poll_options) { build_list(:poll_option, 3) }
    let!(:poll) { create(:poll, poll_options: poll_options )}

    context 'when successful' do
      before { get "/poll/#{poll.id}/stats" }

      it { expect(response).to be_successful }
      it { expect(response.status).to eq 200 }

      it { expect(response_body['views']).to eq 1 }
      it { expect(response_body['votes'].size).to eq 3 }
      it { expect(response_body['votes'].first.has_key?('option_id')).to be true }
      it { expect(response_body['votes'].first.has_key?('qty')).to be true }
    end
  end

  describe 'POST /poll' do
    let(:poll_attributes) { { poll_description: "This is the question", options: ["First option", "Second option", "Third option"] } }

    before { post '/poll', params: poll_attributes }

    it { expect(Poll.count).to eq 1 }
    it { expect(response_body['poll_id']).to eq Poll.last.id }
  end

  describe 'POST /poll/:id/vote' do
    let!(:poll_option) { build(:poll_option) }
    let!(:poll) { create(:poll, poll_options: [poll_option]) }

    context 'when poll exists' do
      context 'when option exists' do
        context 'when option is valid for given poll' do
          before do
            poll.reload
            post "/poll/#{poll.id}/vote", params: { option_id: poll_option.id }
          end

          it { expect(response.status).to eq 204 }
        end

        context 'when option isn\'t valid for given poll' do
          let!(:invalid_poll_option) { build(:poll_option) }
          let!(:another_poll) { create(:poll, poll_options: [invalid_poll_option]) }

          before { post "/poll/#{poll.id}/vote", params: { option_id: invalid_poll_option.id } }

          it { expect(response.status).to eq 400 }
        end
      end

      context 'when option doesn\'t exist' do
        before do
          allow(PollOption).to receive(:find_by).and_return nil
          post "/polls/#{poll.id}/vote", params: { option_id: 1 }
        end

        it { expect(response.status).to eq 404 }
      end
    end

    context 'when poll doesn\'t exist' do
      before do
        allow(Poll).to receive(:find_by).and_return nil
        post '/polls/1/vote', params: { option_id: 1 }
      end

      it { expect(response.status).to eq 404 }
    end
  end
end
