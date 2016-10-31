module ValidationTestHelper  

  def expect_message message
    @message = message
  end

  def reset_current_record model
    @record = model.new &Proc.new
  end

  def assert_validation_failure field, *values
    check_validation field, *values do |value|
      assert_not @record.valid?, validity_check_failure(value, field)

      assert_includes @record.errors[field], @message, messages_mismatch(field)
    end
  end

  def assert_validation_success field, *values
    check_validation field, *values do |value|
      assert @record.valid?, @record.errors.to_xml
    end
  end

private

  def check_validation field, *values
    if values.empty?
      @record.save

      yield "default test value"
    end

    values.each do |value|
      @record.assign_attributes field => value
      @record.save

      yield value
    end
  end

  # Custom assertion failure messages
  def validity_check_failure value, field
    "'#{value}' expected to be an invalid #{@record.class} #{field}"
  end

  def messages_mismatch field
    "Error messages mismatch for #{@record.class} #{field}"
  end

end
