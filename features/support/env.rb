require 'rubygems'
require 'bundler/setup'
#require 'selenium-webdriver'
#require 'colorize'
require 'open3'

Bundler.require(:default)
Dotenv.load

AfterConfiguration do |config|
  # This is a good place to load any configurations such as environments (test/pilot/prod)

  # You can load data files for use in your tests as well

  # Starting PhantomJS server for headless browser testing
  startPhantom()
  sleep(1)

  # Create the PhantomJS driver for use in your web tests
  DRIVER = Selenium::WebDriver.for(:remote, :url => "http://localhost:9134")

  # Set the driver timeout for implicit waits as XX seconds
  DRIVER.manage.timeouts.implicit_wait = 35
  # If you want to use a different timer explicitly in your code
  WAIT = Selenium::WebDriver::Wait.new(:timeout => 35)
end

Before do |scenario|
  # Initialize a screenshot counter for each scenario
  @screen_counter = 1

  # Capture the Feature name
  @feature_name = scenario.feature

  # Scenario name
  @scenario_name = scenario.name

  # Step Count
  @step_count = scenario.step_count

  # Tags (as an array)
  @scenario_tags = scenario.tags
end

#After do |scenario|
#  # You can set Cucumber to quit upon the first test failure it encounters, do that here
#
#end

at_exit do
  # If you had to start up any services (such as PhantomJS or BrowserStack), this would be the place to kill them
  killPhantom()
end
