require "rails_helper"

RSpec.describe "Order", :type => :request do
	let(:order_complete) { FactoryBot.create(:order_complete_a) }
	let(:order_complete_b) { FactoryBot.create(:order_complete_b, merchant: order_complete.merchant) }
	let(:order_complete_c)  { FactoryBot.create(:order_complete_c, merchant: order_complete.merchant) }
	let(:extra_order_complete) { FactoryBot.create(:order_complete_a) } # different merchant
	let(:extra_order_incomplete) { FactoryBot.create(:order_complete_a, completed_at: nil) } # different merchant and incomplete

	context 'valid' do 
		# http_method, action_method, url
		describe 'GET search /orders/search' do
			before do
				# params => start_date, end_date, merchant_id
				@start_date = order_complete.completed_at
				@end_date = @start_date + 7.days # 1 week range
				@start_date = @start_date.strftime('%Y-%m-%d')
				@end_date = @end_date.strftime('%Y-%m-%d')
				@merchant_id = order_complete.merchant_id
				order_complete_b
				order_complete_c
				extra_order_complete
				extra_order_incomplete
			end

			describe 'with given merchant' do
				before do
					get search_orders_path(start_date: @start_date, end_date: @end_date, merchant_id: @merchant_id)
				end

				it 'should returns status 200' do
					expect(response).to have_http_status(:success)
				end

				it 'should return data information' do
					body = body_response(response)
					expect(body[:data].present?).to eq true
				end

				it 'should return data array info with 3 orders' do
					body = body_response(response)
					expect(body[:data].count).to eq 3
				end

				it 'should return :amount, :created_at, :completed_at, :merchant, :fee keys for each object' do
					json_response = body_response(response)
					expect(json_response[:data][0][:attributes].keys).to match_array([:amount, :created_at, :completed_at, :merchant, :fee])
				end
			end

			describe 'without merchant' do
				before do
					get search_orders_path(start_date: @start_date, end_date: @end_date)
				end

				it 'should returns status 200' do
					expect(response).to have_http_status(:success)
				end

				it 'should return data information' do
					body = body_response(response)
					expect(body[:data].present?).to eq true
				end

				it 'should return data array info with 4 orders' do
					body = body_response(response)
					expect(body[:data].count).to eq 4
				end

				it 'should return :amount, :created_at, :completed_at, :merchant, :fee keys for each object' do
					json_response = body_response(response)
					expect(json_response[:data][0][:attributes].keys).to match_array([:amount, :created_at, :completed_at, :merchant, :fee])
				end
			end
		end
	end
	
	context 'invalid' do
		# http_method, action_method, url
		describe 'GET search /orders/search' do
			it 'should not allow start_date param nil' do
				get search_orders_path(start_date: nil, end_date: Date.today)
				body = body_response(response)
				expect(body[:message]).to eq I18n.t('order.search.required')
			end

			it 'should not allow end_date param nil' do
				get search_orders_path(start_date: Date.today, end_date: nil)
				body = body_response(response)
				expect(body[:message]).to eq I18n.t('order.search.required')
			end
		end
	end
end