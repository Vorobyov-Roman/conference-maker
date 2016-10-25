module ValidationTestHelper  

  def expect_message message
    @message = message
  end

  def reset_current_record model
    @record = model.new &Proc.new
  end

  def assert_validation_failure field, *values
    check_validation field, *values do |field, value|
      assert_not @record.valid?, validity_check_failure(false, value, field)

      assert_includes @record.errors[field], @message, messages_mismatch(field)
    end
  end

  def assert_validation_success field, *values
    check_validation field, *values do |field, value|
      assert @record.valid?, validity_check_failure(true, value, field)
    end
  end

private

  def check_validation field, *values
    if values.empty?
      @record.save

      yield field, "default test value"
    end

    values.each do |value|
      @record.assign_attributes field => value
      @record.save

      yield field, value
    end
  end

  # Custom assertion failure messages
  def validity_check_failure should_be_valid, value, field
    expectation = should_be_valid ? "to be" : "to not be"
    "'#{value}' expected #{expectation} a valid #{@record.class} #{field}"
  end

  def messages_mismatch field
    "Error messages mismatch for #{@record.class} #{field}"
  end

end
