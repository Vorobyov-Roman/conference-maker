module Privileges::Utils

  def creator? conference
    conference.creator == @user
  end

  def organizer? conference
    conference.organizers.include? @user
  end

  def moderator? topic
    topic.moderators.include? @user
  end

  def sender? application
    application.sender == @user
  end

private

  EXCEPTIONS = {
    creator?:   { true => UserIsNotTheCreator,  false => UserIsTheCreator  },
    organizer?: { true => UserIsNotAnOrganizer, false => UserIsAnOrganizer },
    moderator?: { true => UserIsNotAModerator,  false => UserIsAModerator  },
    sender?:    { true => UserIsNotASender                                 }
  }

  def check role, obj, expected_to_be
    exception = EXCEPTIONS[role][expected_to_be]
    raise exception.new if expected_to_be ^ self.send(role, obj)
  end

  def self.declare_checker role
    define_method :"check_is_#{role}" do |obj|
      check :"#{role}?", obj, true
    end

    define_method :"check_is_not_#{role}" do |obj|
      check :"#{role}?", obj, false
    end
  end

  def self.declare_manager_wrapper name
    define_method(:"#{name}_manager") do
      @managers_provider.provide name
    end
  end

protected

  declare_checker :creator
  declare_checker :organizer
  declare_checker :moderator
  declare_checker :sender

  declare_manager_wrapper :application
  declare_manager_wrapper :conference
  declare_manager_wrapper :review
  declare_manager_wrapper :topic

end
