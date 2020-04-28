class PollStatsSerializer < ActiveModel::Serializer
  attributes :views, :votes

  def votes
    self.object.poll_options.map do |poll_option|
      { option_id: poll_option.id, qty: poll_option.qty }
    end
  end
end
