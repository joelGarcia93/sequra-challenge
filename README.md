# README

with this API you can get the disbursements for a given merchant on a given week. If no merchant is provided return for all of them.

# End point

https://zip-codes-challenge.herokuapp.com/orders/search?start_date=2018-01-01&end_date=2018-01-07&merchant_id=1


# Request params

- start_date REQUIRED
- end_date REQUIRED
- merchant_id OPTIONAL

# Fee rules

The disbursed amount has the following fee per order:
- 1% fee for amounts smaller than 50 €
- 0.95% for amounts between 50€ - 300€
- 0.85% for amounts over 300€

Example Response:

```json
{
    "data": [
        {
            "id": "10",
            "type": "order",
            "attributes": {
                "amount": "59.33",
                "created_at": "2018-01-01T09:30:00.000Z",
                "completed_at": "2018-01-03T01:02:43.000Z",
                "merchant": {
                    "id": 1,
                    "name": "Flatley-Rowe",
                    "email": "info@flatley-rowe.com",
                    "cif": "B611111111"
                },
                "fee": "0.563635"
            }
        },
        {
            "id": "34",
            "type": "order",
            "attributes": {
                "amount": "260.14",
                "created_at": "2018-01-02T06:54:00.000Z",
                "completed_at": "2018-01-03T21:55:30.000Z",
                "merchant": {
                    "id": 1,
                    "name": "Flatley-Rowe",
                    "email": "info@flatley-rowe.com",
                    "cif": "B611111111"
                },
                "fee": "2.47133"
            }
        },
        {
            "id": "76",
            "type": "order",
            "attributes": {
                "amount": "441.98",
                "created_at": "2018-01-03T20:00:00.000Z",
                "completed_at": "2018-01-04T22:52:52.000Z",
                "merchant": {
                    "id": 1,
                    "name": "Flatley-Rowe",
                    "email": "info@flatley-rowe.com",
                    "cif": "B611111111"
                },
                "fee": "3.75683000000000044198"
            }
        },
        {
            "id": "151",
            "type": "order",
            "attributes": {
                "amount": "204.55",
                "created_at": "2018-01-05T21:36:00.000Z",
                "completed_at": "2018-01-08T09:22:03.000Z",
                "merchant": {
                    "id": 1,
                    "name": "Flatley-Rowe",
                    "email": "info@flatley-rowe.com",
                    "cif": "B611111111"
                },
                "fee": "1.943225"
            }
        },
        {
            "id": "79",
            "type": "order",
            "attributes": {
                "amount": "385.53",
                "created_at": "2018-01-03T23:00:00.000Z",
                "completed_at": "2018-01-05T16:05:09.000Z",
                "merchant": {
                    "id": 1,
                    "name": "Flatley-Rowe",
                    "email": "info@flatley-rowe.com",
                    "cif": "B611111111"
                },
                "fee": "3.27700500000000038553"
            }
        },
        {
            "id": "105",
            "type": "order",
            "attributes": {
                "amount": "78.38",
                "created_at": "2018-01-04T17:05:00.000Z",
                "completed_at": "2018-01-07T00:22:48.000Z",
                "merchant": {
                    "id": 1,
                    "name": "Flatley-Rowe",
                    "email": "info@flatley-rowe.com",
                    "cif": "B611111111"
                },
                "fee": "0.74461"
            }
        },
        {
            "id": "179",
            "type": "order",
            "attributes": {
                "amount": "238.23",
                "created_at": "2018-01-06T15:00:00.000Z",
                "completed_at": "2018-01-09T00:55:59.000Z",
                "merchant": {
                    "id": 1,
                    "name": "Flatley-Rowe",
                    "email": "info@flatley-rowe.com",
                    "cif": "B611111111"
                },
                "fee": "2.263185"
            }
        }
    ]
}
```

### Installation

- git clone https://github.com/joelGarcia93/sequra-challenge.git
- bundle install
- run migrations
- run rake task to setup the information locally
- rails server

### run rspect test's


> rspec spec/requests/zip_codes_spec.rb
