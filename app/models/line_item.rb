class LineItem < ActiveRecord::Base
  belongs_to :bill

  validates :title, :description, :price, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.10}
end
