class SessionsController < ApplicationController
    def new
    end

    def create
      user = User.find_by(email: params[:email])
      if user.present? && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to root_path, notice: "You have been logged in."
      else
        flash.now[:alert] = "There was something wrong with your login details."
        render :new
      end
    end

    def destroy
      if session[:user_id]
          session[:user_id] = nil
          redirect_to root_path, notice: "You have been logged out."
      end
    end
end
