Given(/^the user can connect to "([^"]*)" with title "([^"]*)"$/) do |webpage, page_title|
  # The browser 'DRIVER' gets created in the 'env.rb' file, in the 'AfterConfiguration' method
  DRIVER.get webpage
  # The 'screenShot()' helper method lives in 'phantom_helpers.rb'
  screenShot()

  print "\nPage Title    : #{DRIVER.title}\n".yellow
  print "\nExpected Title: #{page_title}\n".yellow
  expect(DRIVER.title).to eq page_title
end

When(/^the user queries for "([^"]*)"$/) do |term|
  element = WAIT.until{DRIVER.find_element :name => 'q'}
  element.send_keys term
  screenShot()
  element.submit

  print "\nQueried Text:  #{term}\n".green
end

Then(/^the "([^"]*)" "([^"]*)" is present$/) do |link, url|
  screenShot()
  @link = WAIT.until{DRIVER.find_element(:link => link)}
  print "\nFound Link:  #{@link.attribute("href")}\n".green
  expect(@link.attribute("href")).to include url
end

When(/^the user clicks the cucumber link$/) do
  pending # Write code here that will find and click the proper link
  # Hint, you've already found the correct link element above
  # and it has conveniently been assigned to an instance variable: '@link'
end

Then(/^that "([^"]*)" is displayed$/) do |webpage|
  pending # Write code here that verifies we are at the proper URL
  # Hint, it's easy to capture the current URL of a webpage.
  # Google 'ruby selenium get current url' to find out how!
end