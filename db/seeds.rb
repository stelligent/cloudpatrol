User.create(name: "admin", password: "admin", password_confirmation: "admin")

%w{ aws_access_key_id aws_secret_access_key dynamodb_log_table ec2_instance_age ec2_instances_start_time ec2_instances_stop_time opsworks_stack_age opsworks_layer_age opsworks_instance_age opsworks_app_age cloudformation_stack_age }.each do |setting|
  Setting.create(key: setting, value: "", protected: "key")
end

Setting.find_by_key("dynamodb_log_table").update_column(:value, "cloudpatrol-log")
