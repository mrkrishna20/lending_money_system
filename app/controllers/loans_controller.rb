class LoansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_loan, only: [:confirm_request, :reject_request, :repay_loan]

  def new
    @loan = current_user.loans.build
  end

  def create
    @loan = current_user.loans.build(loan_params)
    if @loan.save
      redirect_to users_dashboard_path
    else
      render :new, status: :unprocessable_entity
    end

  end

  def confirm_request
    @loan.admin.update(wallet: @loan.admin.wallet - @loan.amount)
    current_user.update(wallet: current_user.wallet + @loan.amount)
    @loan.update(state: 2)
    redirect_to users_dashboard_path
  end

  def reject_request
    @loan.update(state: 4)
    redirect_to users_dashboard_path
  end

  def repay_loan
    current_user.update(wallet: current_user.wallet - @loan.amount)
    @loan.admin.update(wallet: (@loan.admin.wallet + @loan.amount))
    @loan.update(state: 3)
    redirect_to users_dashboard_path
  end

  protected

  def loan_params
    params.require(:loan).permit(:amount, :admin_id, :state)
  end

  def set_loan
    @loan = current_user.loans.find(params[:loan_id])
  end
end
