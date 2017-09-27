# frozen_string_literal: true
module OmniauthSetup
  def setup_vk_user_with_email(email = 'qwe@wq.qw2')
    vk_user.tap { |u| u.info.merge!(email: email) }
  end

  def setup_vk_user_without_email
    vk_user.tap { |u| u.info.merge!(email: '') }
  end

  def setup_vk_user_without_city
    vk_user.tap { |u| u.extra.raw_info.merge!(city: '', country: '') }
  end

  def setup_vk_user_with_invalid_age(age)
    date = age.to_i.years.ago
    vk_user.tap { |u| u.extra.raw_info.merge!(bdate: date) }
  end

  def setup_vk_user_without_avatar
    vk_user.tap { |u| u.info.merge!(image: nil) }
  end

  def setup_vk_user_without_bdate
    vk_user.tap { |u| u.extra.raw_info.merge!(bdate: nil) }
  end

  def setup_vk_user_with_blank_bdate
    vk_user.tap { |u| u.extra.raw_info.merge!(bdate: '') }
  end

  private

  def vk_user
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:vkontakte] = OmniAuth::AuthHash.new(
      provider: 'vkontakte',
      uid: '123456',
      info: {
        name: 'Cassius Clay',
        image: fixture_file_upload('spec/images/avatars/user1.jpg', 'image/jpeg')
      },
      credentials: { token: 'asdasdq2e31212' },
      extra: {
        raw_info: {
          sex: 2,
          bdate: '19.1.2000',
          city: { title: 'Воронеж' },
          country: { title: 'Россия' }
        }
      }
    )
  end
end

RSpec.configure do |config|
  config.include OmniauthSetup, type: :controller
end
