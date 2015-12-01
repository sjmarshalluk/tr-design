class CompaniesController < ApplicationController

  def index
    @city = City.find(params[:city_id])
    @companies = Company.all.order('name ASC')
  end

  def booklet
    @city = City.find(params[:city_id])
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
    @city = City.find(params[:city_id])
    @companies = Company.where("saturday = ?", "TRUE").order('pitch ASC')
    respond_to do |format|
      format.html
      format.pdf do
        pdf = FloorplanPdf.new(@companies)
        send_data pdf.render, filename: 'floorplan.pdf', type: 'application/pdf'
      end
    end
  end



  def logos
    @city = City.find(params[:city_id])
    @companies = Company.all.order('name ASC')
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
    @city = City.find(params[:city_id])
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(company_params)
      flash[:success] = "Changes saved"
      redirect_to city_companies_path
    else
      flash[:error] = "Nope"
      render :new
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.delete
    flash[:success] = "Deleted"
    redirect_to city_companies_path
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
    :pitch,
    :city_id
  )
end



end
