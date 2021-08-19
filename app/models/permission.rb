# == Schema Information
#
# Table name: permissions
#
#  id         :bigint           not null, primary key
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  section_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_permissions_on_section_id  (section_id)
#  index_permissions_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (section_id => sections.id)
#  fk_rails_...  (user_id => users.id)
#
class Permission < ApplicationRecord
  belongs_to :user
  belongs_to :section
end
