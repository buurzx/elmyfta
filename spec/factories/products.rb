# frozen_string_literal: true

FactoryGirl.define do
  factory :product do
    name { FFaker::Name.name }
    quantity 9
  end
end
