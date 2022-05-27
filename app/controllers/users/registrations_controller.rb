module Users
  class RegistrationsController < Devise::SessionsController
    def new
      @user = User.new
    end

    def create
      binding.pry
      @user = User.new(user_params)
      if @user.save
        redirect_to new_user_session_path, notice: "Pomyślnie utworzono konto"
      else
        render new
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :confirm_password)
    end
  end
end