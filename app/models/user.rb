class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :timeoutable,
         :jwt_authenticatable,
         jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
end
