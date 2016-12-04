require 'test_helper'
require 'validation_test_helper'
require 'fake'

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
  2.7 should have many attended conferences

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
  3.11 can apply for attendance unless they are a part of the organizing staff
  3.12 can apply for attendance unless they have any sent applications to it (uless it has been rejected)

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



    test "2.7 should have many attended conferences" do
      user = build :user, attended_conferences_count: 3
      assert_equal 3, user.attended_conferences.count
    end

  end



  class PrivilegeTest < ActiveSupport::TestCase

    def new_user
      user = build :user

      def user.managers_provider
        Class.new { def self.provide name; Fake.new end }
      end

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



    test "3.7 can send applications unless they are a part of the organizing staff" do
      created_conference = build :conference, creator: user
      organized_conference = build :conference, organizers: [user]

      topic1 = build :topic, conference: created_conference
      topic2 = build :topic, conference: organized_conference
      topic3 = build :topic, moderators: [user]
      topic4 = build :topic

      assert_raises UserIsTheCreator do
        user.send_application topic1, nil
      end

      assert_raises UserIsAnOrganizer do
        user.send_application topic2, nil
      end

      assert_raises UserIsAModerator do
        user.send_application topic3, nil
      end

      assert_nothing_raised do
        user.send_application topic4, nil
      end
    end



    test "3.8 can update application if they are the sender" do
      application1 = build :application
      application2 = build :application, sender: user

      assert_raises UserIsNotASender do
        user.update_application application1, nil
      end

      assert_nothing_raised do
        user.update_application application2, nil
      end
    end



    test "3.9 can update application if its status is not 'accepted' or 'rejected'" do
      pending           = build :application, sender: user
      accepted          = build :accepted_application, sender: user
      rejected          = build :rejected_application, sender: user
      needs_corrections = build :disputable_application, sender: user

      assert_raises ApplicationIsFinal do
        user.update_application accepted, nil
      end

      assert_raises ApplicationIsFinal do
        user.update_application accepted, nil
      end

      assert_nothing_raised do
        user.update_application pending, nil
        user.update_application needs_corrections, nil
      end
    end



    test "3.10 can review an application if they are a moderator of its topic" do
      topic1 = build :topic
      topic2 = build :topic, moderators: [user]

      application1 = build :application, topic: topic1
      application2 = build :application, topic: topic2

      assert_raises UserIsNotAModerator do
        user.review_application application1, nil
      end

      assert_nothing_raised do
        user.review_application application2, nil
      end
    end



    test "3.11 can apply for attendance unless they are a part of the organizing staff" do
      topic = build :topic, moderators: [user]
      moderated_conference = create :conference, topics: [topic]
      organized_conference = build :conference, organizers: [user]
      created_conference = build :conference, creator: user
      valid_conference = build :conference

      assert_raises UserIsTheCreator do
        user.apply_for_attendance created_conference
      end

      assert_raises UserIsAnOrganizer do
        user.apply_for_attendance organized_conference
      end

      assert_raises UserIsAModerator do
        user.apply_for_attendance moderated_conference
      end

      assert_nothing_raised do
        user.apply_for_attendance valid_conference
      end
    end



    test "3.12 can apply for attendance unless they have any sent applications to it" do
      application1 = build :application, sender: user
      application2 = build :rejected_application, sender: user
      application3 = build :accepted_application, sender: user
      application4 = build :disputable_application, sender: user

      topic1 = build :topic, applications: [application1]
      topic2 = build :topic, applications: [application2]
      topic3 = build :topic, applications: [application3]
      topic4 = build :topic, applications: [application4]

      conference1 = create :conference, topics: [topic1]
      conference2 = create :conference, topics: [topic2]
      conference3 = create :conference, topics: [topic3]
      conference4 = create :conference, topics: [topic4]
      conference5 = create :conference

      assert_raises UserIsASender do
        user.apply_for_attendance conference1
      end

      assert_raises UserIsASender do
        user.apply_for_attendance conference3
      end

      assert_raises UserIsASender do
        user.apply_for_attendance conference4
      end

      assert_nothing_raised do
        user.apply_for_attendance conference2
        user.apply_for_attendance conference5
      end
    end

  end

end
