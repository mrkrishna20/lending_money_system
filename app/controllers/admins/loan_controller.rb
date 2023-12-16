class Admins::LoanController < ApplicationController
  before_action :authenticate_admin!

  def update
    @loan = current_admin.loans.find(params[:loan_id])
    if @loan.update(loan_params)
      redirect_to admins_dashboard_path
    end
  end

  def reject_loan
    @loan = current_admin.loans.find(params[:loan_id])
    if @loan.update(state: 3)
      redirect_to admins_dashboard_path
    end
  end

  protected

  def loan_params
    params.require(:loan).permit(:interest_rate, :state)
  end
end
