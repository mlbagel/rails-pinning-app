require 'byebug'
class PinsController < ApplicationController

  before_action :require_login, except: [:show, :show_by_name]

  def index
    @pins = Pin.all
    #@pins = current_user.pins.all
  end

  def show
    @pin = Pin.find(params[:id])
    @users = @pin.users
    @pins = current_user.pins
    @board = Board.find(params[:id])
  end

  def show_by_name
    @pin = Pin.find_by_slug(params[:slug])
    #@pin = current_user.pins.find_by_slug(params[:slug])
    @users=@pin.users
    @user = current_user

    render :show
  end

  def new
    @pin = Pin.new
    #not sure if I need this pinning build here or not?
    @pin.pinnings.build
  end

  def create
    @pin = Pin.create(pin_params)
    #@pin = current_user.pins.new(pin_params)
    if @pin.valid?
        @pin.save
        if params[:pin][:pinning][:board_id]
          board = Board.find(params[:pin][:pinning][:board_id])
          @pin.pinnings.create!(user: current_user, board: board)
        end
        redirect_to pin_path(@pin)
     else
        @errors = @pin.errors
        render :new
    end
  end

  def edit

    @pin = Pin.find(params[:id])
    #@boards = @pin.pinnings.find_by(params[board_id: @user.boards.ids, user_id: @user.id])
    #@boardname = @user.boards.name
    render :edit
  end

  def update
    @pin = Pin.find(params[:id])

    #super complicated useless setup!!!
     #@pin.pinnings.find_by(params[board_id: @user.boards, user_id: @user.id]).update_attribute(:board_id, params[:pin][:pinning][:board_id])

     #another version:
     #@pin = Pin.update(params[:id], pin_params)

     #Pin.update returns the resulting object whether it was saved successfully to the database or not. Therefore, Pin.update(@pin.id, pin_params) does not update the @pin variable if you do not make the assignment; @pin=Pin.update(.....).
     # @pin.update_attributes(pin_params) does change the @pin variable implicitly.
     #The solution for this to work with the update method is to do @pin = Pin.update(@pin.id, pin_params)
require 'byebug'
debugger
    if @pin.update_attributes(pin_params)
        redirect_to pin_path(@pin)
    else
        @errors = @pin.errors
        render :edit
      end
  end

  def repin
    @pin = Pin.find(params[:id])
    board = Board.find(params[:pin][:pinning][:board_id])
    @pin.pinnings.create!(user: current_user, board: board)
    redirect_to user_path(current_user)
  end

  private

  def pin_params
    params.require(:pin).permit(:title, :url, :slug, :text, :category_id, :image, :user_id, pinnings_attributes: [:user_id, :id, :board_id])
    #params.require(:pin).permit(:title, :url, :slug, :text, :category_id, :image, :user_id)
  end
end
