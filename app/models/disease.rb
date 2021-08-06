# == Schema Information
#
# Table name: diseases
#
#  id              :bigint           not null, primary key
#  has_description :boolean
#  list_diases     :jsonb
#  order           :integer
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Disease < ApplicationRecord
  has_many :customer_diseases, dependent: :destroy
  has_many :customers, through: :customer_diseases

  def other_description(customer)
    return 'N/A' unless has_description

    CustomerDisease.where(customer_id: customer.id, disease_id: id)&.last&.description
  end
end
