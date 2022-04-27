class OrderSerializer
  include FastJsonapi::ObjectSerializer
	attributes :amount, :created_at, :completed_at

	attribute :merchant do |object|
		object.merchant.as_json
	end

	attribute :fee do |object|
		object.fee_order
	end
end
