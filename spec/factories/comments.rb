FactoryBot.define do
  factory :comment do
    text { "こめんと" }
    association :user
    association :cat

  end
end
