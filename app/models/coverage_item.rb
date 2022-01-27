# == Schema Information
#
# Table name: coverage_items
#
#  id          :bigint           not null, primary key
#  scale_items :jsonb
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class CoverageItem < ApplicationRecord
  validates :title, uniqueness: true
end
