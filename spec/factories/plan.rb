# frozen_string_literal: true

FactoryBot.define do
  factory :plan do
    title { Faker::Lorem }
    coverage { Faker::Lotem }
    coverage_items { Faker::Json.add_depth_to_json(json: json, width: 21, options: { key: 'Item -', value: '100%' }) }
    payment_fee { Faker::Number.decimal_part(digits: 2) }
  end
end
