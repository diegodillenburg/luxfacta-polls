require 'rails_helper'

RSpec.describe 'PollOptionsService', type: :service do
  context '#call' do
    let(:input) { ["First Option", "Second Option", "Third Option"] }

    let(:service) { PollOptionsService.new(input) }

    before { service.call }

    it { expect(service.output.all? { |e| e.instance_of? PollOption }).to be true }
    it { expect(service.output.collect { |e| e.option_description }).to match_array input }
  end
end
