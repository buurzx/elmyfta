# frozen_string_literal: true

module ApplicationHelper
  def elevated?
    controller_name == 'pages'
  end
end
