# frozen_string_literal: true
class Public::SessionsController < Devise::SessionsController
   #before_action :configure_sign_in_params, only: [:create]
  #before_action :_customer, only: [:create]
 def create
     super
 end
 
 def destroy
     super
 end
 def after_sign_in_path_for(resource) 
  customers_path
 end
 
 
    protected
 
# 退会しているかを判断するメソッド
  def customer_state
  ## 【処理内容1】 入力されたemailからアカウントを1件取得
    @customer = Customer.find_by(email: params[:customer][:email])
  ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@customer
  ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @customer.valid_password?(params[:customer][:password])
    ## 【処理内容3
    end
  end
  #GET /resource/sign_in
   #def new
  #   super
   #end
  # POST /resource/sign_in
  
  # DELETE /resource/sign_out
 
  # If you have extra params to permit, append them to the sanitizer.
 # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
 # end

  
#  def reject_customer
 #   @customer = Customer.find_by(email: params[:name][:email])
#    if @customer
 ##     if (@customer.valid_password?(params[:member][:password]) && (@member.active_for_authentication? == false))
  #      flash[:error] = "退会済みです。"
  #      redirect_to new_custom_session_path
   #   end
    #else
     # flash[:error] = "必須項目を入力してください。"
    #end
  #end
end
