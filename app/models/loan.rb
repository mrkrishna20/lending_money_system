class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :admin

  validates :amount, presence: true, numericality: {greater_than: 0}
  validates :interest_rate, presence: true, numericality: {greater_than_or_equal_to: 0}
  validate :amount_cannot_exceed_wallet, on: :create

  enum state: [:requested, :approved, :open, :closed, :rejected]

  def calculate_interest
    update(amount: amount + (amount * interest_rate/100))
  end

  def process_loan
    if amount > user.wallet
      admin.update(wallet: (admin.wallet + user.wallet))
      user.update(wallet: 0)
      update(state: "closed")
    end
  end

  private

  def amount_cannot_exceed_wallet
    if amount.present? && amount > user.wallet
      errors.add(:amount, "cannot exceed the user's wallet amount")
    end
  end
end
