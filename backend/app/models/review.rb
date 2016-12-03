class Review < ApplicationRecord
  enum status: [ :accepted, :rejected, :disputable ]
end
