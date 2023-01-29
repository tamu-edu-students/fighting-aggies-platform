# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'user attributes must not be empty' do
    user = User.new
    assert user.invalid?
    assert user.errors[:name].any?
    assert user.errors[:role].any?
    assert user.errors[:email].any?
  end

  test 'user email must be unique' do
    user = User.new(name: 'John', role: 'Coach', email: users(:one).email)
    assert user.invalid?
    assert_equal ['has already been taken'], user.errors[:email]
  end

  test 'user role must be valid' do
    user = User.new(name: 'John', role: 'Invalid', email: 'john@example.com')
    assert user.invalid?
    assert_equal ['is not included in the list'], user.errors[:role]
  end

  test 'create user' do
    user = User.new(name: 'John', role: 'Coach', email: 'john@example.com')
    assert user.save
  end

  test 'update user' do
    user = users(:one)
    assert user.update(name: 'Jane')
    assert_equal 'Jane', user.name
  end

  test 'delete user' do
    user = users(:one)
    assert user.destroy
  end
end
