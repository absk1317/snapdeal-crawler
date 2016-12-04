module ApplicationHelper
  def color(color)
    color.present? ? color.capitalize : 'NA'
  end

  def amount(amount)
    amount.present? ? "₹ #{amount}" : 'NA'
  end

  def truncated_url(url)
    url.split("").each_with_object("") do
      |x,ob| break ob unless (ob.length + " ".length + x.length <= 80);ob << ("" + x)
    end.strip
  end
end
