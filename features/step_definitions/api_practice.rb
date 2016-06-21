Given(/^the client can make an API "([^"]*)" call to the "([^"]*)" "([^"]*)" with this "([^"]*)"$/) do |command, host, service, response|
  uri = URI("#{host}#{service}")

  http = Net::HTTP.new(uri.host, uri.port, p_addr=ENV['proxy_host'],
                       p_port=ENV['proxy_port'], p_user=ENV['proxy_user'], p_pass=ENV['proxy_pass'])

  if POSTMAN_DATA['messages'][response]['use_ssl'] and POSTMAN_DATA['messages'][response]['use_ssl'].to_s == 'true'
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end

  case command
    when 'get'
      @request = Net::HTTP::Get.new(uri)
  end

  POSTMAN_DATA['messages'][response].each do |key, param|
    case key
      when 'body'
        @request.body = "'#{param}'"
        print "request.body = #{param}\n".yellow
      when 'basic_auth'
        user, pass = param.split('|')[0], param.split('|')[1]
        @request.basic_auth user, pass
        print "request.basic_auth '#{user}', '#{pass}'\n".yellow
      else
        @request["'#{key}'"] = "'#{param}'"
        print "request[#{key}] = #{param}\n".yellow
    end
  end

  @response = http.request(@request)
end

Then(/^the client will receive the proper "([^"]*)" in return$/) do |response|
  #print "\nResponse: #{@response.to_s}\n".yellow
  print "\nBody    : #{@response.read_body}\n".yellow
  print "Code    : #{@response.code}\n".yellow
  expect(@response.read_body).to eq POSTMAN_DATA['responses'][response]['read_body']
  expect(@response.code).to eq POSTMAN_DATA['responses'][response]['code'].to_s
end
