class Api::UserController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token 
  # GET /users or /users.json
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1 or /users/1.json
  def show
     render json: @user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      render json: {message: "user create successfuly"}
    else
      render json: {message: "Error"}
    end      
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if @user.update(user_params)
      render json: {message: "user updated successfuly"}
    else
      render json: {message: "Error"}
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    render json: {message: "user Deleted successfuly"}
  end

  def typeahead 
    search = params[:input]
    query = "first_name = /.*#{search}.*/ OR last_name = /.*#{search}.*/ OR email = /.*#{search}.*/"
    # @users = User.where(query)
    # @users = User.where('$or' => [ { :first_name => /.*#{search}.*/ , :last_name => /.*#{search}.*/, :email => /.*#{search}.*/} ])
    @users = User.where({:first_name => "/#{search}/i"})
    render json: @users
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end
end
