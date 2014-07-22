class Bill < ActiveRecord::Base
	has_many :line_items, dependent: :destroy 
	belongs_to :user
	#accepts_nested_attributes_for :line_items
	validates :name, :limit_date, presence: true

	def total_price
		line_items.to_a.sum{ |item| item.price}
	end

end
