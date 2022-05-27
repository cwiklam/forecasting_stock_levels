class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :current_user_exist?
  include Response

  private

  def current_user_exist?
    if current_user.blank?
      redirect_to new_user_session_path
    end
  end
end
