FactoryBot.define do
  factory :poll_option do
    sequence(:option_description) { |n| "Option #{n}"}
    poll_id { nil }
  end
end
