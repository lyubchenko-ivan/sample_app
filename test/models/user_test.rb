require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: 'User', email: 'user@mail.com', password: 'foobar', password_confirmation: 'foobar')
  end



  test "valid model" do
    assert @user.valid?
  end

  test 'should be present name' do
    @user.name = '    '
    assert_not @user.valid?
  end


  test 'should be present email' do
    @user.email = '  '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test 'email validation should accept valid addresses' do
    addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                   first.last@foo.jp alice+bob@baz.cn]

    addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]

    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end


  test 'addresses should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?

  end


  test 'password should have a minimal length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end
end
