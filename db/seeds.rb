User.create(name: "admin", password: "admin", password_confirmation: "admin")

Setting.create(key: "aws_access_key_id", value: "", protected: "key")
Setting.create(key: "aws_secret_access_key", value: "", protected: "key", masked: true)
Setting.create(key: "dynamodb_log_table", value: "cloudpatrol-log", protected: "key")

%w{ ec2_instance_age opsworks_stack_age opsworks_layer_age opsworks_instance_age opsworks_app_age cloudformation_stack_age rules_run_at }.each do |setting|
  Setting.create(key: setting, value: "", protected: "key")
end
