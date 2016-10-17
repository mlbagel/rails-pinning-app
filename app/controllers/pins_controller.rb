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
    @board = @pin.pinnings.find_by(params[:board_id])
  end

  def show_by_name
    @pin = Pin.find_by_slug(params[:slug])
    #@pin = current_user.pins.find_by_slug(params[:slug])
    @users=@pin.users
    render :show
  end

  def new
    @pin = Pin.new
    @pin.pinnings.build
  end

  def create
    @pin = Pin.new(pin_params)
    if @pin.valid?
        @pin.save
        redirect_to pin_path(@pin)
     else
        @errors = @pin.errors
        render :new
    end
  end

  def edit
#debugger
    @pin = Pin.find(params[:id])
    @boards = @pin.pinnings.find_by(params[:board_id])
    render :edit
  end

  def update
    #debugger
    @pin = Pin.find(params[:id])
    #@pin.pinning = current_user.pinning.find(params[:board_id])

# we want the id of the pinning which the pinnings table assigned to the pinning so that we can update the correct pinning, and not move sallie's pinned hairstyle into kyle's video game board
    @pin.pinnings.find_by(params[:board_id]).update_attribute(:board_id, params[:pin][:pinning][:board_id])
    #@boards = @pin.pinnings.find_by(params[:board_id])
    #@pin.pinnings.update_attribute(params[:pin][:pinning][:board_id])
    if @pin.update(pin_params)
      redirect_to pin_path(@pin)
    else
      @errors = @pin.errors
      render :edit
    end
  end

  def repin
    @pin = Pin.find(params[:id])
    @pin.pinnings.create(user: current_user, board_id: params[:pin][:pinning][:board_id])
    redirect_to user_path(current_user)
  end

  private

  def pin_params
    params.require(:pin).permit(:title, :url, :slug, :text, :category_id, :image, :user_id, pinnings_attributes: [:user, :pin, :board])
  end
end
