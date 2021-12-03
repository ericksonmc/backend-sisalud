# == Schema Information
#
# Table name: scales
#
#  id         :bigint           not null, primary key
#  amount     :float
#  category   :integer
#  quantity   :integer
#  status     :integer
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Scale < ApplicationRecord
  enum status: { inactive: 0, active: 1 }
  enum category: {
    surgery: 0,
    gynecology_and_obstetrics: 1,
    orl: 2,
    traumatology: 3,
    endoscopy: 4,
    ultrasound: 5,
    hospitalization: 6,
    consultation: 7,
    cardiology: 8,
    special_laboratory: 9,
    studies: 10,
    emergency: 11,
    basic_lab: 12
  }

  scope :with_limit, -> { where.not(quantity: nil) }
end
