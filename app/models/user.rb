# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  active                 :boolean          default(TRUE), not null
#  agent_code             :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  last_otp_at            :integer
#  otp_secret             :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("super_admin"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :timeoutable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  enum role: { super_admin: 0, admin: 1, agent: 2, manager: 3, assitant: 4, coordinator: 5, doctor: 6 }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, email: true
  has_many :agreements
  has_many :permissions, dependent: :destroy

  accepts_nested_attributes_for :permissions

  def to_s
    [first_name, last_name].compact.join(' ')
  end

  def authorize_permissions
    authorize_permissions = {}

    permissions.each{ |permission|
      authorize_permissions[permission.section.name] = Hash.new
      authorize_permissions[permission.section.name]['active'] = permission.active
    }
    authorize_permissions
  end

  def valid_for_delete?
    !agreements.present?
  end
end
