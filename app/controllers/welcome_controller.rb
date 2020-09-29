class WelcomeController < ApplicationController
    def index
        render json: { status: 200, message: "YD2H User Accounts API" }
      end
end
