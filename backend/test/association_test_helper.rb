module AssociationTestHelper  

  def assert_inverse_of_many record, this, other
    indirect_record = (record.send this).first.send other

    assert_same record, indirect_record, inversity_failure(this, other)
  end

  def assert_inverse_of_one record, this, other
    indirect_record = (record.send this).send other

    assert_same record, indirect_record, inversity_failure(this, other)
  end

private

  def inversity_failure this, other
    "'#{this}' should be inverse of '#{other}'"
  end

end
