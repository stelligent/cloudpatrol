module ApplicationHelper
  def title text
    content_for(:title, text) if text.present?
  end

  def flash_bootstrap type, text
    type_alert =
      case type
      when :notice
        "alert-info"
      when :alert
        "alert-error"
      else
        "alert-success"
      end
    content_tag :div, text, class: "alert #{type_alert}"
  end
end
