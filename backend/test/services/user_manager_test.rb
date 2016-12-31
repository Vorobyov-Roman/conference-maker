require 'test_helper'

=begin

1 Creating a user
  1.1 should create a new user

2 Searching for a user
  2.1 should find by login

=end

class UserManagerTest < ActiveSupport::TestCase

  def setup
    @manager ||= Managers::UserManager.new FactoryGirl
    @user    ||= @manager.create_user login: "unique_login"
  end



  test "1.1 should create a new user" do
    assert_includes User.all, @user
  end



  test "2.1 should find by login" do
    assert_equal @user, @manager.find_by_login("unique_login")
    assert_raises ActiveRecord::RecordNotFound do
      @manager.find_by_login "wrong_login"
    end
  end

end
