class Tools::JWTHelper

  def initialize serializer
    @serializer = serializer
  end

  def encode user
    JWT.encode @serializer.to_json(user), secret
  end

  def decode token
    JWT.decode token, secret
  end

private

  def secret
    Rails.application.secrets.secret_key_base
  end

end
