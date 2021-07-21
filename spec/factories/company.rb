# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    description { Faker::Company }
    rif { Faker::IDNumber }

    association :products, factory: :product
  end
end
