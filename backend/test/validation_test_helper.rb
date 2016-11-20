module ValidationTestHelper

  def self.included base
    base.class_eval do
      def initialize args
        super args

        /(?<model>.+)Test/ =~ "#{self}".deconstantize

        @factory = model.downcase.to_sym
        @strategy = :build
        @params = {}
      end
    end
  end

  def using params
    @strategy = params.delete(:strategy) { @strategy }
    @params.merge! params
  end



  def assert_invalid field, message, *values
    check_validity_of field, values do |record, value|
      assert_not record.valid?
      assert_includes record.errors[field], message
    end
  end

  def assert_valid field, *values
    check_validity_of field, values do |record, value|
      assert record.valid?
    end
  end

private

  def new_record params
    self.send @strategy, @factory, params.merge(@params)
  end

  def check_validity_of field, values
    values.each do |value|
      record = new_record field => value

      yield record, value
    end
  end

end
