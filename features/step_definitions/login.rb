require 'rubygems'
require 'watir'

Before do
  @browser = Watir::Browser.new
  if not Dir.exists? "screenshots"
    FileUtils.mkdir "screenshots"
  end
end

After do |scenario|
  if scenario.failed? 
    screenshot_file_path = "screenshots/#{scenario.title}-#{Time.now}.png"
    @browser.screenshot.save screenshot_file_path
    embed screenshot_file_path, 'image/png'
  end
  @browser.close
end

Given(/^the CloudPatrol URL has been specified$/) do
  ENV['CloudPatrolURL'].should_not be_nil
end

Given(/^the password has been specified$/) do
  ENV['CloudPatrolPassword'].should_not be_nil
end

When(/^I navigate to \/login$/) do
  @browser.goto ENV['CloudPatrolURL']+'/login'
end

When(/^I login with username "(.*?)"$/) do |username|
  @browser.text_field(:name => 'name').set username
  @browser.text_field(:name => 'password').set ENV['CloudPatrolPassword'] 
  @browser.button(:name => 'button').click 
end

Then(/^I should see the text "(.*?)"$/) do |text_to_find|
  @browser.text.should match(text_to_find), @browser.text
end
