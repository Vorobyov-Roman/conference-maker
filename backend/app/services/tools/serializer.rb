class Tools::Serializer

  def to_json record
    self.send :"#{class_name record}_to_json", record
  end

private

  def class_name record
    record.class.to_s.downcase
  end

  def self.serialize model, *fields
    define_method :"#{model}_to_json" do |record|
      record.as_json only: fields
    end
  end

  serialize :user, :id, :name, :email

end
