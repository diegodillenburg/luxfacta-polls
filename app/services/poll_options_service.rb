class PollOptionsService
  def self.call(input)
    new(input).call
  end

  attr_reader :input, :output

  def initialize(input)
    @input = input
    @output = []
  end

  def call
    @input.each do |option_description|
      @output << PollOption.new(option_description: option_description)
    end

    @output
  end
end
