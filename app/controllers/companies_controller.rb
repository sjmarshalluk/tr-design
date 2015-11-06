class CompaniesController < ApplicationController

  def index
    @companies = Company.all.order('name ASC')
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new
    if @company.save
      flash[:success] = "That saved"
      redirect_to root_path
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end

  def show
    @company = Company.find(params[:id])
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(company_params)
      flash[:success] = "Changes saved"
      redirect_to company_path
    else
      flash[:error] = "Nope"
      render :new
    end
  end

  def import
    Companies.import(params[:file])
  end


private

def company_params
  params.require(:company).permit(
    :name,
    :mission,
    :tech_stack,
    :hiring_saturday,
    :hiring_sunday,
    :hiring_contact,
    :founded,
    :team_size,
    :right
  )
end



end
