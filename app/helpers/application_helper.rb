module ApplicationHelper
  def cart_item_count
    (session[:cart] || {}).values.sum(&:to_i)
  end

  def order_status_pill_class(state)
    case state.to_s
    when "new_order" then "is-new"
    when "paid"      then "is-paid"
    when "shipped"   then "is-shipped"
    else "is-muted"
    end
  end
end
