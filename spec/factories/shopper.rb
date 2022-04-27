FactoryBot.define do
	factory :shopper do
		name { Faker::Name.name }
		email { Faker::Internet.unique.email }
		nif { Faker::Code.npi }
	end
end