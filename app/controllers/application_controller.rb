class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :current_url

    def current_url
        session[:current_url] = 1
    end
end
