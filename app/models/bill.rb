class Bill < ActiveRecord::Base
  has_many :line_items, dependent: :destroy 
  belongs_to :user

  validates :name, :limit_date, :status, presence: true
 
  Status = %w[Waiting Paid]
  def total_price
    line_items.to_a.sum{ |item| item.price}
  end

  def change_status(status)
   	self.status = status
   	save
  end

end
