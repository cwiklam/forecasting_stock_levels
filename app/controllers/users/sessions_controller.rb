module Users
  class SessionsController < Devise::SessionsController
    skip_before_action :current_user_exist?, only: %i[new create]

    def new
      @user = User.new
    end

    def create
      super
      flash[:notice] = "Pomyślnie zalogowano" if signed_in?
    end

    def destroy
      super
      flash[:notice] = "Pomyślnie wylogowano" unless signed_in?
    end
  end
end