module Users
  class RegistrationsController < Devise::SessionsController
    skip_before_action :current_user_exist?, only: %i[new create]

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to new_user_session_path, notice: "Pomyślnie utworzono konto"
      else
        render 'new', status: 400
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :confirm_password)
    end
  end
end