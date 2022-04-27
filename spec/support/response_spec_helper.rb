module ResponseSpecHelper
	def body_response(response)
		JSON.parse(response.body).deep_symbolize_keys
	end
end