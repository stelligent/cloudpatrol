module CommandsHelper
  def aws_setting key
    link_to(
    if @settings[key].present?
      content_tag(:span, "#{key} = #{@settings[key]}", title: key.to_s)
    else
      content_tag(:span, "#{key}", class: "undefined")
    end, settings_path)
  end
end
