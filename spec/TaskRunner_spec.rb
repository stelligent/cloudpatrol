require 'spec_helper'

puts "#{Time.now} :: task runner tests running"

describe 'TaskRunner' do

  context 'clean stacks' do
    it 'should send an empty whitelist to the CloudPatrol facade when run is invoked and there are no whitelist values' do
      fake_creds = { :access_key_id => '', :secret_access_key => ''}
      TaskRunner.any_instance.stub(:creds) { fake_creds }
      TaskRunner.any_instance.stub(:log_table_name) { 'fake_log_table_name' }

      update_setting_value('opsworks_stack_age', '6')

      expect(Cloudpatrol).to receive(:perform)
        .with(fake_creds, 'fake_log_table_name', :OpsWorks, :clean_stacks, 6, [])

      task_runner = TaskRunner.new({ :class => 'OpsWorks', :method => 'clean_stacks' })
      task_runner.run
    end

    it 'should send the whitelist values as an array to Cloudpatrol facade' do
      fake_creds = { :access_key_id => '', :secret_access_key => ''}
      TaskRunner.any_instance.stub(:creds) { fake_creds }
      TaskRunner.any_instance.stub(:log_table_name) { 'fake_log_table_name' }

      update_setting_value('opsworks_stack_age', '7')

      update_setting_value('whitelist1', '1234')

      update_setting_value('whitelist2', '5678')

      expect(Cloudpatrol).to receive(:perform)
        .with(fake_creds, 'fake_log_table_name', :OpsWorks, :clean_stacks, 7, %w{1234 5678})

      task_runner = TaskRunner.new({ :class => 'OpsWorks', :method => 'clean_stacks' })
      task_runner.run
    end
  end

  def update_setting_value(setting_key, value)
    setting = Setting.find_by_key(setting_key)
    setting.value = value
    setting.save
  end
end

puts "#{Time.now} :: task runner tests complete"
