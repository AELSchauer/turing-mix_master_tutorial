FactoryGirl.define do
  factory :playlist do
    sequence(:name) { |n| "My Jams #{n}"}
  end
end