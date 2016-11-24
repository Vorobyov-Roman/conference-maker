class Review < ApplicationRecord
  enum status: [ :accepted, :rejected, :needs_corrections ]
end
