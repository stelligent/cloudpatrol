class CloudpatrolTasks
  def self.delete_iam_users_without_mfa
    iam = AWS.iam
    iam.users.each do |user|
      unless user.name =~ /_/ or user.mfa_devices.count > 0
        puts "#{user.name} is going to be deleted"
        user.delete
      end
    end
  end

  def self.delete_expired_keypairs
  end

  def self.delete_resources
  end

  def self.toggle_ec2_during_nonbusiness_hours
    ec2 = AWS.ec2
    ec2.instances.each do |instance|
      case action
      when :start
        instance.start
      when :stop
        instance.stop
      end
    end
  end

  def self.delete_ports_assigned_to_default
  end
end
