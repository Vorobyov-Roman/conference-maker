class InsufficientPermissions < StandardError
end

class UserIsNotTheCreator < InsufficientPermissions
end

class UserIsNotAnOrganizer < InsufficientPermissions
end
