# == Schema Information
#
# Table name: municipalities
#
#  id         :bigint           not null, primary key
#  capital    :string
#  parish     :jsonb
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  state_id   :bigint           not null
#
# Indexes
#
#  index_municipalities_on_state_id  (state_id)
#
# Foreign Keys
#
#  fk_rails_...  (state_id => states.id)
#
class Municipality < ApplicationRecord
  belongs_to :state
end
