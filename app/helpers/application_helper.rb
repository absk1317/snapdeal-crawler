module ApplicationHelper
  def color(color)
    color.present? ? color.capitalize : 'NA'
  end

  def amount(amount)
    amount.present? ? "₹ #{amount}" : 'NA'
  end
end
