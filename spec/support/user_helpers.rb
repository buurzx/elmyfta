# frozen_string_literal: true
module UserHelpers
  def create_user_with_last_action_ago(n = nil)
    time = n ? n.minutes.ago : Time.current.utc
    create(:user, last_action_at: time)
  end

  def sign_in(user = double('user'))
    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, scope: :user)
      allow(controller).to receive(:current_user).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
  end
end

RSpec.configure do |config|
  config.include UserHelpers, type: :model
end
