require 'spec_helper'

describe 'TaskRunner' do

  it 'should send the proper parameters to the CloudPatrol facade when run is invoked' do
    fake_creds = { :access_key_id => '', :secret_access_key => ''}
    TaskRunner.any_instance.stub(:creds) { fake_creds }
    TaskRunner.any_instance.stub(:log_table_name) { 'fake_log_table_name' }

    mock_setting = double(Setting)
    expect(Setting).to receive(:find_by_key)
      .with('opsworks_stack_age')
      .and_return(mock_setting)

    expect(mock_setting).to receive(:value)
      .and_return(6)

    expect(Cloudpatrol).to receive(:perform)
      .with(fake_creds, 'fake_log_table_name', :OpsWorks, :clean_stacks, 6)

    task_runner = TaskRunner.new({ :class => 'OpsWorks', :method => 'clean_stacks' })
    task_runner.run
  end
end