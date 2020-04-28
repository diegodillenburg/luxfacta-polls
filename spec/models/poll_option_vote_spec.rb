require 'rails_helper'

RSpec.describe PollOptionVote, type: :model do
  it { is_expected.to belong_to(:poll_option) }
end
