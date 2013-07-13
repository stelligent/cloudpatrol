module CommandsHelper
  def aws_setting key
    link_to (@settings[key].present? ? content_tag(:span, "#{key} = #{@settings[key]}", title: key.to_s, class: "aws-setting") : content_tag(:span, "#{key}", class: "aws-setting undefined")), settings_path
  end

  def perform_link options
    link_to "perform", { action: :perform }.update(options), class: "perform", id: "#{options[:class]}-#{options[:method]}" unless @disable_commands
  end
end
