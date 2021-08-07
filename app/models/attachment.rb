# == Schema Information
#
# Table name: attachments
#
#  id            :bigint           not null, primary key
#  description   :string
#  fileable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  fileable_id   :integer
#
class Attachment < ApplicationRecord
  belongs_to :fileable, polymorphic: true, optional: true
  has_many_attached :files
end
