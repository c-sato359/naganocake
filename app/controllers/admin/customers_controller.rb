class Admin::CustomersController < ApplicationController

  before_action :authenticate_admin!
  #会員一覧
  def index
    #@search = Customer.ransack(params[:q])
    @customers = Customer.all
  end

  def show
    @customers = Customer.all
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customers_path(@customer)
      flash[:notice_update] = "情報を更新しました！"
    else
      edit_admin_customer_path(@customer)
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephon_number, :email, :is_deleted)
  end
end
