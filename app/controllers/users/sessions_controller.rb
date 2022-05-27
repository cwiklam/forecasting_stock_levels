module Users
  class SessionsController < Devise::SessionsController
    def new
      @user = User.new
    end

    def create
      super
    end
  end
end