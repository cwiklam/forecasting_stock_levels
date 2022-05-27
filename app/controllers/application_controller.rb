class ApplicationController < ActionController::Base
  before_action :current_user_exist?
  skip_before_action :verify_authenticity_token
  skip_before_action :current_user_exist?, if: :json_request?

  include Response

  private

  def current_user_exist?
    if current_user.blank?
      redirect_to new_user_session_path
    end
  end

  def json_request?
    request.headers['Content-Type'] == 'application/json' && request.headers['Accept'] == 'application/json'
  end
end
