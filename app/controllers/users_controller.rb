class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_token, except: [:login, :create, :index, :profile]
  before_action :authorize_user, except: [:login, :create, :index, :profile]

  # GET /users
  def index
    @users = User.all

    render json:  @users
  end
  
  # GET /users/1
  def show
    render json: @user
  end

  #Get User Profile users/profile/username
  def profile
    @oneuser = User.find_by(username: params[:username]) 
    profile = user_profile(@oneuser.id, @oneuser.username, @oneuser.email, @oneuser.first_name, @oneuser.last_name, @oneuser.avatar_img, @oneuser.created_at) 
    render json: profile
  end

  # POST /signup
  def create
    @user = User.new(user_params)

    if @user.save
      @new_user = User.last
      #sends email to wlecome new users
      WelcomeMailer.welcome_email(user).deliver
      token = create_token(@new_user.id, @new_user.username) 
      idcard = current_user(@new_user.id, @new_user.username, @new_user.email, @new_user.first_name, @new_user.last_name, @new_user.avatar_img, @new_user.created_at)
      render json: { status: :created, location: @user, token: token, idcard: idcard}
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  def login                                                                        
    user = User.find_by(username: params[:user][:username])            
    if user && user.authenticate(params[:user][:password])                         
      token = create_token(user.id, user.username) 
      idcard = current_user(user.id, user.username, user.email, user.first_name, user.last_name, user.avatar_img, user.created_at)                                
      render json: { status: 200, token: token, idcard: idcard }                       
    else                                                                           
      render json: { status: 401, message: "Unauthorized" }                        
    end                                                                            
  end

 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:username, :first_name, :last_name, :email, :avatar_img, :password_digest, :password)
    end

    def payload(id, username)
      {
        exp: (Time.now + 30.minutes).to_i,
        iat: Time.now.to_i,
        iss: ENV['JWT_ISSUER'],
        user: {
          id: id,
          username: username
        }
      }
    end

    def create_token(id, username)
      JWT.encode(payload(id, username), ENV['JWT_SECRET'], 'HS256')
    end

    def current_user(id, username, email, first_name, last_name, avatar_img, created_at) 
     {
        id: id,
        username: username,
        email: email,
        first_name: first_name,
        last_name: last_name,
        img: avatar_img,
        member_since: Time.at(created_at).strftime("%B %e, %Y")
      }
    end

    def user_profile(id, username, email, first_name, last_name, avatar_img, created_at) 
      {
         id: id,
         username: username,
         email: email,
         first_name: first_name,
         last_name: last_name,
         img: avatar_img,
         member_since: Time.at(created_at).strftime("%B %e, %Y")
       }
     end

end
