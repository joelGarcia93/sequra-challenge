require 'csv'

namespace :catalogs do
	# change this to your own PC PATH
	PATH = '/Users/joelgarcia/Documents/catalogs_sat'

	# merchants
	task :merchant => :environment do
		ActiveRecord::Base.connection.execute("copy merchants(id,name,email,cif) FROM '#{PATH}/merchants.csv' DELIMITER ',' CSV")
	end

	# shoppers
	task :shopper => :environment do
		ActiveRecord::Base.connection.execute("copy shoppers(id,name,email,nif) FROM '#{PATH}/shoppers.csv' DELIMITER ',' CSV")
	end

	# orders
	task :order => :environment do
		#creating temporary table to avoid 
		#PG::DatetimeFieldOverflow: ERROR:  date/time field value out of range issue on copy for local
		ActiveRecord::Base.connection.execute(<<-SQL
				CREATE TABLE pg_temp.order_temporary(id int, merchant_id int, shopper_id int, 
				amount decimal(9,2), created_at varchar, completed_at varchar);
			SQL
		)

		# copy info from csv to temporary table
		ActiveRecord::Base.connection.execute(<<-SQL
			COPY pg_temp.order_temporary(id,merchant_id,shopper_id,amount,created_at,completed_at) 
			FROM '#{PATH}/orders.csv' DELIMITER ',' CSV
			SQL
		)
		
		# inserting correct format info in final orders table
		ActiveRecord::Base.connection.execute(<<-SQL
				INSERT INTO public.orders(id,merchant_id,shopper_id,amount,created_at,completed_at)
				SELECT id,merchant_id,shopper_id,amount,to_date(created_at, 'DD/MM/YYYY'),to_date(completed_at, 'DD/MM/YYYY')
				FROM   pg_temp.order_temporary;
			SQL
		)
	end

	task :order_server => :environment do
		path = Rails.root.join('app', 'lib', 'catalogs', 'orders.csv')
		orders = []
		CSV.foreach(path, headers: false) do |row|
			id = row[0]
			merchant_id = row[1]
			shopper_id = row[2]
			amount = row[3]
			created_at = row[4]
			completed_at = row[5]
			order = Order.new(id: id, merchant_id: merchant_id, shopper_id: shopper_id, 
			amount: amount, created_at: created_at, completed_at: completed_at)
			orders.push(order)
		end
		Order.import orders
	end
end