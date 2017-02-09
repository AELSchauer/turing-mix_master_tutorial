FactoryGirl.define do
  factory :song do
    artist
    sequence(:title) { |n| "Jamming #{n}"}
  end
end
