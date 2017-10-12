# frozen_string_literal: true

require 'ffaker'

10.times do
  name = "#{FFaker::NameRU.last_name} #{FFaker::NameRU.first_name} #{FFaker::NameRU.patronymic}"

  org = Organization.create(name: FFaker::Vehicle.make,
                            inn: rand(0o0000000000..99_999_999_999).to_s)
  User.create(name: name,
              email: FFaker::Internet.email,
              password: FFaker::Internet.password,
              organization_id: org.id)
end

Organization.find_each do |org|
  20.times do
    org.products.create!(name: "#{FFaker::Vehicle.model} #{FFaker::Vehicle.model}",
                         quantity: rand(50..200))
  end
end
