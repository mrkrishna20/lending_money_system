class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def dashboard
    @loan_requests = current_admin.loans.where(state: [0, 1, 2, 3]).includes(:user)
    @wallet = current_admin.wallet
  end
end
