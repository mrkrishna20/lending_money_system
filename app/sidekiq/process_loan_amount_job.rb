class ProcessLoanAmountJob
  include Sidekiq::Job

  def perform(*args)
    Loan.where(state: "open").each do |loan|
      loan.process_loan
    end  end
end
