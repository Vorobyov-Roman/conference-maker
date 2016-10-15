ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical
  # order.
  fixtures :all

  # Assertions used by validation tests
  def assert_validation_failure(record, field, expected_error, *values)
    values.each do |value|
      modify_record(record, field, value)

      assert_not      record.valid?,
                      validity_check_failure(false, value, record.class, field)
      assert_includes record.errors[field], expected_error,
                      error_messages_mismatch(record.class, field)
    end
  end

  def assert_validation_success(record, field, *values)
    values.each do |value|
      modify_record(record, field, value)

      assert record.valid?,
             validity_check_failure(true, value, record.class, field)
    end
  end

private
  def modify_record(record, field, value)
    record.assign_attributes(field => value)

    record.save
  end

  # Custom assertion failure messages
  def validity_check_failure(should, value, model, field)
    expectation = should ? "to be" : "to not be"
    "'#{value}' expected #{expectation} a valid #{model} #{field}"
  end

  def error_messages_mismatch(model, field)
    "Error messages mismatch for #{model} #{field}"
  end
end
