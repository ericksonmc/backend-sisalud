# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    description { Faker::Lorem }
    title { Faker::Lotem }

    association :plans, factory :plan
  end
end
