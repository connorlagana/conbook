class Comment < ApplicationRecord
  # model association
  belongs_to :post

  # validation
  validates_presence_of :name
end