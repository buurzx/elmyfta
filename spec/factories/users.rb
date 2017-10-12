# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    name { FFaker::Name.name }
    password '123123'

    factory :user_with_organization do
      before(:create) do |user|
        user.organization = create(:organization)
      end
    end
  end
end
