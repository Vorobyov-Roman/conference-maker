module Privileges::Utils

  def creator_of? conference
    conference.creator == @user
  end

  def organizer_of? conference
    conference.organizers.include? @user
  end

  def moderator_of? topic
    topic.moderators.include? @user
  end

  def moderator_in? conference
    @user.moderated_topics.where(conference: conference).any?
  end

  def sender_of? application
    application.sender == @user
  end

  def sender_in? conference, *permitted_statuses
    sent_applications = (@user.sent_applications & conference.applications)
      .reject { |a| permitted_statuses.include? a.status }
      .any?
  end

  def final? application
    application.status == :accepted || application.status == :rejected
  end

private

  EXCEPTIONS = {
    creator_of?:   { true => UserIsNotTheCreator,  false => UserIsTheCreator   },
    organizer_of?: { true => UserIsNotAnOrganizer, false => UserIsAnOrganizer  },
    moderator_of?: { true => UserIsNotAModerator,  false => UserIsAModerator   },
    moderator_in?: { true => UserIsNotAModerator,  false => UserIsAModerator   },
    sender_of?:    { true => UserIsNotASender,     false => UserIsASender      },
    sender_in?:    { true => UserIsNotASender,     false => UserIsASender      },
    final?:        {                               false => ApplicationIsFinal }
  }

  def check role, *params, expected_to_be
    exception = EXCEPTIONS[role][expected_to_be]
    raise exception.new if expected_to_be ^ self.send(role, *params)
  end

  def self.declare_checker role
    define_method :"check_is_#{role}" do |*params|
      check :"#{role}?", *params, true
    end

    define_method :"check_is_not_#{role}" do |*params|
      check :"#{role}?", *params, false
    end
  end

  def self.declare_manager_wrapper name
    define_method(:"#{name}_manager") do
      @managers_provider.provide name
    end
  end

protected

  declare_checker :creator_of
  declare_checker :organizer_of
  declare_checker :moderator_of
  declare_checker :moderator_in
  declare_checker :sender_of
  declare_checker :sender_in
  declare_checker :final

  declare_manager_wrapper :application
  declare_manager_wrapper :conference
  declare_manager_wrapper :review
  declare_manager_wrapper :topic

end
