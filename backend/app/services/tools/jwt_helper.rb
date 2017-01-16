class Tools::JWTHelper

  def initialize serializer
    @serializer = serializer
  end

  def encode user
    JWT.encode @serializer.new(user).as_json, secret
  end

  def decode token
    JWT.decode(token, secret)[0]
  end

private

  def secret
    Rails.application.secrets.secret_key_base
  end

end
