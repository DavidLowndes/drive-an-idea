class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: %i[show edit update destroy]
  before_action :set_search
  load_and_authorize_resource
  
  def index
    @companies = @search.result.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end
  
  def show
    @users = User.where(company_id: @company.id)
  end
  
  def new
    @company = Company.new
  end
  
  def edit    
  end
  
  def create
    @company = Company.new(company_params)
    
    if @company.save
      redirect_to @company, notice: 'Company was created!'
      
    else
      render :new
    end
    
  end
  
  def update
    if @company.update(company_params)
      redirect_to @company, notice: 'Company updated!'
    else
      render :edit
    end
  end
  
  def destroy
    @company.destroy
    redirect_to companies_path, alert: 'Company Deleted!'
  end
  
  private
  
  def set_company
    @company = Company.find(params[:id])
  end
  
  def company_params
    params.require(:company).permit(:company_name)
  end
  
  def set_search
    @search = Company.ransack(params[:q])
  end
end
