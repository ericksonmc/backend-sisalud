# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    describe 'validations' do
      it 'allows values', factory: :stub do
        is_expected.to allow_values('valid-password-1234', 'another9876').for(:password)
        is_expected.to allow_values('onlyalphabetic', '123456789').for(:password)
        is_expected.not_to allow_values('', nil).for(:password)

        is_expected.to allow_values('Name', 'Name Test').for(:first_name)
        is_expected.to allow_values('LastName', 'Last Name').for(:last_name)

        is_expected.not_to allow_values('', '').for(:first_name)
        is_expected.not_to allow_values('', '').for(:last_name)

        is_expected.to allow_values('test@test.com', 'TEST@TEST.COM').for(:email)
        is_expected.not_to allow_values('test@', 'test@test', 'test@test.', 'test @test. com')
          .for(:email)
      end
    end
  end
end
