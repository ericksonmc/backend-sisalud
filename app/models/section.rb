# == Schema Information
#
# Table name: sections
#
#  id          :bigint           not null, primary key
#  module_name :integer
#  name        :string
#  pretty_name :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Section < ApplicationRecord
  enum module_name: { products: 0, plans: 1, users: 2, customers: 3, admin_dashboars: 4, scales: 5 }

  has_many :permissions

  after_create :add_permission

  def add_permission
    User.all.each do |user|
      user.permissions.create(section_id: id, active: false)
    end
  end
end
