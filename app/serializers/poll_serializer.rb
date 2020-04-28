class PollSerializer < ActiveModel::Serializer
  attributes :poll_id, :poll_description, :options

  def poll_id
    self.object.id
  end

  def options
    self.object.poll_options.map do |poll_option|
      { option_id: poll_option.id, option_description: poll_option.option_description }
    end
  end

end
