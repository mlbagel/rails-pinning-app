require 'spec_helper'
RSpec.describe FollowersController do
  before(:each) do
    @user = FactoryGirl.create(:user_with_followees)
    @board = @user.boards.first
    login(@user)
  end
  after(:each) do
    if !@user.destroyed?
      Follower.where("follower_id=?", @user.id).first.destroy
      @user.destroy
    end
  end

  describe "GET index" do

    it 'renders the index template' do
    end

    it 'populates @followed with all followed users' do
    end

    it 'redirects to the login page if user is not logged in' do
    end

  end

  describe "GET new" do
    it 'responds with successfully' do
    end

    it 'renders the new view' do
    end

    it 'assigns an instance variable to a new pin' do
    end

    it 'assigns @users to equal the users not followed by @user' do
    end

    it 'redirects to the login page if user is not logged in' do
    end
  end

  describe "POST create" do
    before(:each) do
      @follower_user = FactoryGirl.create(:user)
      @follower_hash = {
        user_id: @user.id,
        follower_id: @follower_user.id
      }
    end

    after(:each) do
      follower = Follower.where("user_id=? AND follower_id=?", @user.id, @follower_user.id)
      if !follower.empty?
        follower.destroy_all
        @follower_user.destroy
      end
    end

    it 'responds with a redirect' do
    end

    it 'creates a follower' do
    end

    it 'redirects to the index view' do
    end

    it 'redirects to the login page if user is not logged in' do
    end
  end

end
