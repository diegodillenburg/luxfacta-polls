class Poll < ApplicationRecord
  has_many :poll_options
  has_many :poll_views

  validates :poll_description, presence: true

  accepts_nested_attributes_for :poll_options

  def views
    self.poll_views.count
  end

  def increment_views
    self.poll_views.create
  end
end
