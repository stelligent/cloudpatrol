module CommandsHelper
  def aws_setting key
    link_to(
    if @settings[key].present?
      content_tag(:span, "#{key} = #{@settings[key]}", title: key.to_s, class: "aws-setting")
    else
      content_tag(:span, "#{key}", class: "aws-setting undefined")
    end, settings_path)
  end

  def perform_link options
    link_to "perform", { action: :perform }.update(options), class: "perform", id: "#{options[:class]}-#{options[:method]}" unless @disable_commands
  end
end
