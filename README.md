# README

Load data from a thirty party

* Technologies:

  Mongodb for good performance

  Rubocop to check ruby style

  Rspec for test
  
  IDE: Rubymine


* Set up and code

    1. Create the app:

    rails new
  Hometime_RubyonRails_API_MongoDB --skip-bundle --skip-active-record --skip-test --skip-system-test --api

    2. Create models
    
    rails generate model Guest first_name:string last_name:string email:string phone:array 

    Email: require and unique

    rails generate model Reservation code:string start_date:date end_date:date payout_price:bigdecimal localized_description:string adults:integer children:integer infants:integer status:integer security_price:bigdecimal currency:string nights:integer total_price:bigdecimal guests:integer

    Code: require and unique

    3. Write tests for models
  
    4. Create Reservation controller
  
       rails generate controller Reservations load
  
       {POST load, params: payload, return: "true" or "false"}
        
        Write Payload, a controller concern for better read
    5. Write tests for the controller
    
* How to run the test suite

    bundle exec rspec
