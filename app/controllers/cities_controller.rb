class CitiesController < ApplicationController

  def index
    @cities = City.all.order('name ASC')
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new
    if @city.save
      flash[:success] = "That saved"
      redirect_to root_path
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end

  def show
    @city = City.find(params[:id])
  end

  def edit
    @city = City.find(params[:id])
  end

  def update
    @city = City.find(params[:id])
    if @city.update(city_params)
      flash[:success] = "Changes saved"
      redirect_to root_path
    else
      flash[:error] = "Nope"
      render :new
    end
  end



private

def city_params
  params.require(:city).permit(
    :name
  )
end



end
