class OrdersController < ApplicationController
	def search
		if params[:start_date].blank? || params[:end_date].blank?
			render json: { message: I18n.t('order.search.required') }, status: :forbidden
			return
		end
		orders = Order.joins(:merchant).includes(:merchant)
		.where("completed_at >= ? AND completed_at <= ?", params[:start_date], params[:end_date])
		.where(order_params)
		.where.not(completed_at: nil)
		data = OrderSerializer.new(orders).serialized_json
		render json: data
	end

	private
	def order_params
		params.permit(:merchant_id).reject { |k, v| v.blank? }
	end
end