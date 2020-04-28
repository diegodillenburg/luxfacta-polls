class PollOption < ApplicationRecord
  belongs_to :poll

  has_many :poll_option_votes

  validates :option_description, presence: true

  def qty
    self.poll_option_votes.count
  end

  def vote
    self.poll_option_votes.create
  end
end
