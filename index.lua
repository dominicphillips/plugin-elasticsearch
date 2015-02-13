local JSON     = require('json')
local timer    = require('timer')
local http     = require('http')
local boundary = require('boundary')

local __pgk = "BOUNDARY ELASTICSEARCH"

function berror(err)
  if err then print(string.format("%s ERROR: %s", __pgk, tostring(err))) return err end
end

--- do a http request
local doreq = function(host, port, path, cb)
    local output = ""
    local req = http.request({host = host, port = port, path = path}, function (res)
      res:on("error", function(err)
        cb("Error while receiving a response: " .. tostring(err), nil)
      end)
      res:on("data", function (chunk)
        output = output .. chunk
      end)
      res:on("end", function ()
        res:destroy()
        cb(nil, output)
      end)
    end)
    req:on("error", function(err)
      cb("Error while sending a request: " .. tostring(err), nil)
    end)
    req:done()
end

local poll = 1000
local host = "localhost"
local port = 9200

if (boundary.param ~= nil) then
  poll = boundary.param['poll'] or poll
  host = boundary.param['host'] or host
  port = boundary.param['port'] or port
end

print("_bevent:ElasticSearch plugin up : version 1.0|t:info|tags:elasticsearch,lua,plugin")

timer.setInterval(poll, function ()

  doreq(host, port, "/_cluster/health", function(err, body)
      if berror(err) then return end
      health = JSON.parse(body)
      print(string.format("ELASTIC_CLUSTERNAME %s", health["cluster_name"]))
      print(string.format("ELASTIC_STATUS %s", health["status"]))
      print(string.format("ELASTIC_TIMED_OUT %s", health["timed_out"]))
      print(string.format("ELASTIC_NUMBER_OF_NODES %d", health["number_of_nodes"]))
      print(string.format("ELASTIC_NUMBER_OF_DATA_NODES %d", health["number_of_data_nodes"]))
      print(string.format("ELASTIC_ACTIVE_PRIMARY_SHARDS %d", health["active_primary_shards"]))
      print(string.format("ELASTIC_ACTIVE_SHARDS %d", health["active_shards"]))
      print(string.format("ELASTIC_RELOCATING_SHARDS %d", health["relocating_shards"]))
      print(string.format("ELASTIC_INITIAZING_SHARDS %d", health["initializing_shards"]))
      print(string.format("ELASTIC_UNASSIGNED_SHARDS %d", health["unassigned_shards"]))
  end)

end)




