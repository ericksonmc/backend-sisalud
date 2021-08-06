# == Schema Information
#
# Table name: states
#
#  id         :bigint           not null, primary key
#  capital    :string
#  cities     :jsonb
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class State < ApplicationRecord
  has_many :municipalities
end
