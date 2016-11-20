ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase

  # Allow to ommit the prefix
  include FactoryGirl::Syntax::Methods

end
