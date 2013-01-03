class ProfilesController < ApplicationController
  def index

  end
  def new
    @profile = Profile.new()
  end

  def create
    @profile = Profile.new(params[:profile])
    #raise params.to_yaml
    if @profile.save
       redirect_to profile_path(:id => @profile.id), notice: 'Profile was successfully created.'
    end
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update

    @profile = Profile.find params[:id]
    if @profile.update_attributes(params[:profile])
         redirect_to profile_path(:id => @profile.id), notice: 'Profile was successfully updated.'
     end
  end
end
