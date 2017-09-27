# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    name { FFaker::Name.name }
    inn '1231231321'
    org_name "Test Org"
    password '123123'
  end
end
