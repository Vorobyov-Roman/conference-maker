class InvalidPermissions < StandardError; end
  class UserIsNotTheCreator < InvalidPermissions; end
  class UserIsTheCreator < InvalidPermissions; end
  class UserIsNotAnOrganizer < InvalidPermissions; end
  class UserIsAnOrganizer < InvalidPermissions; end
  class UserIsNotAModerator < InvalidPermissions; end
  class UserIsAModerator < InvalidPermissions; end
  class UserIsNotASender < InvalidPermissions; end
  class UserIsASender < InvalidPermissions; end

class BadResource < StandardError; end
  class ApplicationIsFinal < BadResource; end

class InternalError < StandardError; end
  class UnspecifiedFactory < InternalError; end
  class UnknownStrategy < InternalError; end
