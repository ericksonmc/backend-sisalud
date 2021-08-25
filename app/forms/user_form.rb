# frozen_string_literal: true

class UserForm < BaseForm

  attr_writer :first_name,
              :last_name,
              :email,
              :password,
              :role,
              :active,
              :agent_code,
              :permissions_attributes

  def initialize(args: {}, user: nil)
    super(args)
    @args = args
    @user = user || User.new(args)
    @new_record = @user.new_record?
    @models = [@user]
  end

  def before_validation
    assign_attributes_to_admin_user

  end

  private

  def assign_attributes_to_admin_user
    byebug
    attributes = @args.tap do |args|
      @args[:id] = @user.id
    end
    @user.assign_attributes(attributes)
  end
  
end
