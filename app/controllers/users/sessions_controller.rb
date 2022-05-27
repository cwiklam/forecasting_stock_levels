module Users
  class SessionsController < Devise::SessionsController
    skip_before_action :current_user_exist?, only: %i[new create]

    def new
      @user = User.new
    end

    def create
      super
    end

    def destroy
      super
    end
  end
end