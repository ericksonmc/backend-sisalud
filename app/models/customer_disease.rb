# == Schema Information
#
# Table name: customer_diseases
#
#  id          :bigint           not null, primary key
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :bigint           not null
#  disease_id  :bigint           not null
#
# Indexes
#
#  index_customer_diseases_on_customer_id  (customer_id)
#  index_customer_diseases_on_disease_id   (disease_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#  fk_rails_...  (disease_id => diseases.id)
#
class CustomerDisease < ApplicationRecord
  belongs_to :customer
  belongs_to :disease
end
