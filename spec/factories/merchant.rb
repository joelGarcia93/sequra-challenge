FactoryBot.define do
    factory :merchant do
        name { Faker::Company.unique.name }
        email { Faker::Internet.unique.email }
        cif { Faker::Code.npi }
    end
end