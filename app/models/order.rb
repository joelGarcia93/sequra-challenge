# frozen_string_literal: true

class Order < ActiveRecord::Base
	belongs_to :shopper
	belongs_to :merchant
	validates_presence_of :amount, :created_at

	def fee_order
		if amount < 50
			(1.0 / 100) * amount
		elsif amount >= 50 && amount <= 300
			(0.95 / 100) * amount
		elsif amount > 300
			(0.85 / 100) * amount
		end
	end
end
    