class Application < ApplicationRecord

  def status
    return :pending if reviews.empty?

    result = :accepted

    reviews.find_each do |review|
      return :rejected if review.rejected?

      result = :disputable if review.disputable?
    end

    result
  end

  def pending?
    status == :pending
  end

  def accepted?
    status == :accepted
  end

  def rejected?
    status == :rejected
  end

  def disputable?
    status == :disputable
  end

end
