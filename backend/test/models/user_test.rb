require 'test_helper'
require 'validation_test_helper'

=begin

1 Validation
  1.1 Name
    1.1.1 should be at least 5 characters long
    1.1.2 should only contain letters and spaces
    1.1.3 should not begin or end with a space
    1.1.4 should mot contain more than 1 space in a row
  1.2 Email
    1.2.1 should be a valid address
    1.2.2 should be unique
  1.3 Login
    1.3.1 should be unique
    1.3.2 should be at least 5 characters long
    1.3.3 should not contain special characters
  1.4 Password
    1.4.1 should be at least 5 characters long

2 Associations
  2.1 should have many created conferences
  2.2 should have many organized conferences
  2.3 should have many moderated topics
  2.4 should have many sent applications
  2.5 should have many reviews
  2.6 should have many reviewed applications

3 Privileges
  3.1 can create a conference
  3.2 can assign organizers if they are the creator
  3.3 can remove organizers if they are the creator
  3.4 can create a topic if they are an organizer
  3.5 can assign moderators if they are an organizer
  3.6 can remove moderators if they are an organizer
  3.7 can send applications unless they are a part of the organizing staff
  3.8 can update application if they are the sender
  3.9 can update application if its status is not 'accepted' or 'rejected'
  3.10 can review an application if they are a moderator of its topic

=end

module UserTest

  class ValidationTest < ActiveSupport::TestCase

    include ValidationTestHelper

    MESSAGES = {
      name_too_short:       "The name should be at least 5 characters long",
      name_not_a_word:      "The name should only contain letters and spaces",
      name_space_at_edge:   "The name should not begin or end with a space",
      name_spaces:          "The name can only have a single space in a row",

      email_invalid:        "The email should be a valid address",
      email_taken:          "This email is already taken",

      login_taken:          "This login is already taken",
      login_too_short:      "The login should be at least 5 characters long",
      login_bad_characters: "The login should not contain special characters",

      password_too_short:   "The password should be at least 5 characters long"
    }



    test "1.1.1 a name should be at least 5 characters long" do
      assert_invalid :name, MESSAGES[:name_too_short], nil, "", "aaaa"
      assert_valid :name, "aaaaa"
    end



    test "1.1.2 a name should only contain letters and spaces" do
      assert_invalid :name, MESSAGES[:name_not_a_word], "0_-"
      assert_valid :name, "valid name"
    end



    test "1.1.3 a name should not begin or end with a space" do
      assert_invalid :name, MESSAGES[:name_space_at_edge], " a", "a "
    end



    test "1.1.4 a name should contain no more than 1 space in a row" do
      assert_invalid :name, MESSAGES[:name_spaces], "a  a"
      assert_valid :name, "v a l i d n a m e"
    end



    test "1.2.1 an email should be a valid address" do
      assert_invalid :email, MESSAGES[:email_invalid], "", "invalid", "i@val@d"
      assert_valid :email, "valid@email"
    end



    test "1.2.2 an email should be unique" do
      using strategy: :create
      assert_valid :email, "dummy@gmail.com"

      using strategy: :build
      assert_invalid :email, MESSAGES[:email_taken], "dummy@gmail.com"
    end



    test "1.3.1 a login should be unique" do
      using strategy: :create
      assert_valid :login, "dummy_login"

      using strategy: :build
      assert_invalid :login, MESSAGES[:login_taken], "dummy_login"
    end



    test "1.3.2 a login should be at least 5 characters long" do
      assert_invalid :login, MESSAGES[:login_too_short], nil, "", "aaaa"
      assert_valid :login, "validlogin"
    end



    test "1.3.3 a login should not contain special characters" do
      assert_invalid :login, MESSAGES[:login_bad_characters], %Q{`~!@#$%^&*()=+}
      assert_valid :login, "lo_gin", "lo-gin", "lo.gin", "l0gin"
    end



    test "1.4.1 a password should be at least 5 characters long" do
      assert_invalid :password, MESSAGES[:password_too_short], nil, "", "aaaa"
      assert_valid :password, "validpassword"
    end

  end



  class AssociationsTest < ActiveSupport::TestCase

    test "2.1 should have many created conferences" do
      user = build :user, created_conferences_count: 2
      assert_equal 2, user.created_conferences.count
    end



    test "2.2 should have many organized conferences" do
      user = build :user, organized_conferences_count: 3
      assert_equal 3, user.organized_conferences.count
    end



    test "2.3 should have many moderated topics" do
      user = build :user, moderated_topics_count: 4
      assert_equal 4, user.moderated_topics.count
    end



    test "2.4 should have many sent applications" do
      user = build :user, sent_applications_count: 3
      assert_equal 3, user.sent_applications.count
    end



    test "2.5 should have many reviews" do
      user = build :user, reviews_count: 2
      assert_equal 2, user.reviews.count
    end



    test "2.6 should have many reviewed applications" do
      user = build :user, reviews_count: 2
      assert_equal 2, user.reviewed_applications.count
    end

  end



  class PrivilegeTest < ActiveSupport::TestCase

    class FakeBasicUser < Privileges::BasicUser
      def create_conference params; end
    end

    class FakeConferenceCreator < Privileges::ConferenceCreator
      def assign_organizers *users; end
      def remove_organizer  *users; end
    end

    class FakeConferenceOrganizer < Privileges::ConferenceOrganizer
      def create_topic      conference, params; end
      def assign_moderators topic, *users;      end
      def remove_moderators topic, *users;      end
    end

    def new_user
      user = build :user

      def user.basic_user_wrapper;           FakeBasicUser           end
      def user.conference_creator_wrapper;   FakeConferenceCreator   end
      def user.conference_organizer_wrapper; FakeConferenceOrganizer end

      user
    end

    def user
      @user ||= new_user
    end



    test "3.1 can create a conference" do
      assert_nothing_raised do
        user.create_conference nil
      end
    end



    test "3.2 can assign organizers if they are the creator" do
      conference1 = build :conference
      conference2 = build :conference, creator: user

      assert_raises UserIsNotTheCreator do
        user.assign_organizers conference1, nil
      end

      assert_nothing_raised do
        user.assign_organizers conference2, nil
      end
    end



    test "3.3 can remove organizers if they are the creator" do
      conference1 = build :conference
      conference2 = build :conference, creator: user

      assert_raises UserIsNotTheCreator do
        user.assign_organizers conference1, nil
      end

      assert_nothing_raised do
        user.assign_organizers conference2, nil
      end
    end



    test "3.4 can create a topic if they are an organizer" do
      conference1 = build :conference
      conference2 = build :conference, organizers: [user]

      assert_raises UserIsNotAnOrganizer do
        user.create_topic conference1, nil
      end

      assert_nothing_raised do
        user.create_topic conference2, nil
      end
    end



    test "3.5 can assign moderators if they are an organizer" do
      topic1 = build :topic
      topic2 = build :topic, conference: build(:conference, organizers: [user])

      assert_raises UserIsNotAnOrganizer do
        user.assign_moderators topic1, nil
      end

      assert_nothing_raised do
        user.assign_moderators topic2, nil
      end
    end



    test "3.6 can remove moderators if they are an organizer" do
      topic1 = build :topic
      topic2 = build :topic, conference: build(:conference, organizers: [user])

      assert_raises UserIsNotAnOrganizer do
        user.assign_moderators topic1, nil
      end

      assert_nothing_raised do
        user.assign_moderators topic2, nil
      end
    end

  end

end
