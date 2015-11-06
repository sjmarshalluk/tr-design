class WayfindingsController < ApplicationController


  def index
    @wayfindings = Wayfinding.all
  end

  def new
    @wayfinding = Wayfinding.new
  end

  def create
    @wayfinding = Wayfinding.new(wayfinding_params)
    if @wayfinding.save
      flash[:success] = "That saved"
      redirect_to wayfindings_path
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end

  def show
    @wayfinding = Wayfinding.find(params[:id])
  end

  def edit
    @wayfinding = Wayfinding.find(params[:id])
  end

  def update
    @wayfinding = Wayfinding.find(params[:id])
    if @wayfinding.update(wayfinding_params)
      flash[:success] = "Changes saved"
      redirect_to wayfinding_path
    else
      flash[:error] = "Nope"
      render :new
    end
  end



private

def wayfinding_params
  params.require(:wayfinding).permit(
    :first_content,
    :first_left,
    :first_right,
    :second_content,
    :second_left,
    :second_right,
    :third_content,
    :third_left,
    :third_right,
  )
end




end
