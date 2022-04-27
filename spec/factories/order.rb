FactoryBot.define do
	factory :order_complete_a, class: 'Order' do
		merchant
		shopper
		amount { 36 }
		created_at { Date.today - 15.days }
		completed_at { Date.yesterday }
	end
	factory :order_complete_b, class: 'Order' do
		merchant
		shopper
		amount { 293 }
		created_at { Date.today - 15.days }
		completed_at { Date.today }
	end
	factory :order_complete_c, class: 'Order' do
		merchant
		shopper
		amount { 369 }
		created_at { Date.today - 15.days }
		completed_at { Date.today }
	end
end