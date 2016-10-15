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

      assert_not(
        record.valid?,
        "'#{field}' expected to not be a valid #{record.class} #{field}"
      )
      assert_includes(
        record.errors[field], expected_error,
        "Error messages mismatch for an invalid #{record.class} #{field}"
        )
    end
  end

  def assert_validation_success(record, field, *values)
    values.each do |value|
      modify_record(record, field, value)

      assert(
        record.valid?,
        "'#{value}' expected to be a valid #{record.class} #{field}"
      )
    end
  end

private
  def modify_record(record, field, value)
    record.send(:"#{field}=", value)

    record.save
  end
end
