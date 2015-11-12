class CompaniesController < ApplicationController

  def index
    @companies = Company.all.order('name ASC')
  end

  def all
    @companies = Company.all.order('name ASC')
    respond_to do |format|
      format.html
      format.pdf do
        pdf = CompanyPdf.new(@companies)
        send_data pdf.render, filename: 'company.pdf', type: 'application/pdf'
      end
    end
  end

  def floorplan
    @companies = Company.where(":name = '1ROOF'").order('name ASC')
  end

  def import
    Company.import(params[:file])
    redirect_to root_url, notice: "Products imported."
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
      redirect_to '/all'
    else
      flash[:error] = "Nope"
      render :new
    end
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
    :right,
    :logo,
    :saturday,
    :sunday,
    :pitch
  )
end



end
