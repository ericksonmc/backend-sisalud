# == Schema Information
#
# Table name: diseases
#
#  id              :bigint           not null, primary key
#  has_description :string
#  list_diases     :jsonb
#  order           :integer
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Disease < ApplicationRecord
end
