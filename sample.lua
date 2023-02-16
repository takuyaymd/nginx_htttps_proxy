-- Load required libraries
local https = require "ssl.https"

-- Define the upstream servers
local upstream_servers = {
  "https://server1.example.com",
  "https://server2.example.com",
  "https://server3.example.com"
}

-- Define the request handler function
local function request_handler()
  -- Set the upstream server to the first server in the list
  local upstream_server = upstream_servers[1]
  
  -- Loop through the upstream servers and try to make a request
  for _, server in ipairs(upstream_servers) do
    local status, body = https.request{
      url = server .. ngx.var.request_uri,
      method = ngx.req.get_method(),
      headers = ngx.req.get_headers(),
      source = ngx.req.get_body_data(),
      verify = "none"
    }
    
    -- If the request was successful, break out of the loop
    if status == 200 then
      upstream_server = server
      break
    end
  end
  
  -- Set the upstream server and pass the response to the client
  ngx.var.upstream = upstream_server
  ngx.say(body)
end

-- Call the request handler function
request_handler()
