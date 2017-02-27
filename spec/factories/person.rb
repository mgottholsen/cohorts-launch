# frozen_string_literal: true
devices = Cohorts::Application.config.device_mappings
connections = Cohorts::Application.config.connection_mappings

FactoryGirl.define do
  factory :person do
    first_name        { Faker::Name.first_name }
    last_name         { Faker::Name.last_name }
    email_address     { Faker::Internet.email }
    phone_number      { Faker::PhoneNumber.cell_phone }
    address_1         { Faker::Address.street_address }
    address_2         { Faker::Address.secondary_address }
    city              { Faker::Address.city }
    state             { Faker::Address.state }
    postal_code       { Faker::Address.zip }
    signup_at         Time.current
    primary_device_id devices[:desktop]
    primary_device_description { Faker::Hipster.sentence }
    secondary_device_id devices[:tablet]
    secondary_device_description { Faker::Hipster.sentence }
    primary_connection_id connections[:phone]
    primary_connection_description { Faker::Hipster.sentence }
    secondary_connection_id connections[:public_wifi]
    secondary_connection_description { Faker::Hipster.sentence }
  end
end
