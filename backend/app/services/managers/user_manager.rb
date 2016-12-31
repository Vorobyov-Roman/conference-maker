class Managers::UserManager

  def initialize factory
    @factory = factory
  end

  def create_user params
    @factory.create :user, params
  end

  def find_by_login login
    User.where(login: login).take!
  end

end
