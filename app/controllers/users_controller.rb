class UsersController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @loans = current_user.loans.where(state: [1, 2, 3])
    @wallet = current_user.wallet
  end
end
