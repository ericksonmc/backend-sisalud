# frozen_string_literal: true

FactoryBot.define do
  factory :plan do
    title { Faker::Lorem }
    coverage { Faker::Lotem }
    coverage_items do
      Faker::Json.add_depth_to_json(json: json, width: 21,
                                    options: { key: 'Item -', value: '100%' })
    end
    payment_fee { Faker::Number.decimal_part(digits: 2) }
  end
end
