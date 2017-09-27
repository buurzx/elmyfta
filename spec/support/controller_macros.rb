# frozen_string_literal: true
module ControllerMacros
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      user.confirm
      sign_in user
    end
  end

  def login_user_with_params(params:)
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryGirl.create(:user, params)
      user.confirm
      sign_in user
    end
  end

  def api_login_user(email = 'tt@tt.tt', pass = '123123')
    before(:each) do
      user = create(
        :user,
        :confirmed,
        email: email,
        password: pass,
        sex: 1,
        birthday: 22.years.ago,
        role: 1
      )
      token = JWTWrapperService.encode(user_id: user.id)
      @request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user
    end
  end
end
