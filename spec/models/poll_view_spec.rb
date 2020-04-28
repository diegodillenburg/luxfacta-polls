require 'rails_helper'

RSpec.describe PollView, type: :model do
  it { is_expected.to belong_to(:poll) }
end
