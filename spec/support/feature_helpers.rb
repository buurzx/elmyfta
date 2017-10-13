# frozen_string_literal: true

module FeatureHelpers
  def login(user = create(:user))
    user.skip_confirmation!
    login_as user, scope: :user
    user
  end

  def money_to_number(string)
    string.gsub(/[^\d\.,]/, '').to_f
  end

  def set_to_balance(user, amount)
    user.balance.update_attributes(amount: amount)
  end
end
