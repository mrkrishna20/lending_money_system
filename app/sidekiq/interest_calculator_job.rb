require 'sidekiq-scheduler'
class InterestCalculatorJob
  include Sidekiq::Job

  def perform(*args)
    Loan.where(state: "open").each do |loan|
      loan.calculate_interest
    end
  end
end
