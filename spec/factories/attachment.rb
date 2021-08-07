
FactoryBot.define do
  factory :attachment do
    description { Faker::Lotem }
    fileable_id nil
    fileable_type nil

  end
end