FactoryBot.define do
  factory :cat do
    message {"可愛い" }
    prefecture_id {2}
    area {"西宮市"}
    place {"公園"}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end