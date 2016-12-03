class InsufficientPermissions < StandardError; end
  class UserIsNotTheCreator < InsufficientPermissions; end
  class UserIsNotAnOrganizer < InsufficientPermissions; end
  class UserIsNotAModerator < InsufficientPermissions; end
  class UserIsNotASender < InsufficientPermissions; end

class UserIsOrganizingStaff < StandardError; end
  class UserIsTheCreator < UserIsOrganizingStaff; end
  class UserIsAnOrganizer < UserIsOrganizingStaff; end
  class UserIsAModerator < UserIsOrganizingStaff; end

class InternalError < StandardError; end
  class UnspecifiedFactory < InternalError; end
  class UnknownStrategy < InternalError; end
