def startPhantom()
  #>> phantomjs --webdriver=PORT
  #>> phantomjs --webdriver=9134
  print "\nStarting:  phantomjs --webdriver=9134\n".yellow
  Open3.popen3("phantomjs --webdriver=9134")
end

def killPhantom()
  print "\nAttempting to kill:  phantomjs\n".yellow
  Open3.popen3("kill $(pgrep phantomjs)")
end

def screenShot()
  DRIVER.save_screenshot("/vagrant/screenshots/#{@feature_name}-#{@scenario_name}-screen-#{@screen_counter}.png")
  @screen_counter += 1
end