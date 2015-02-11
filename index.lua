local JSON = require('json')
local fs = require('fs')
local timer = require('timer')
local http = require('http')

local doreq = function(host, port, path, cb)
    local output = ""
    local req = http.request({host = host, port = port, path = path}, function (res)
      res:on("error", function(err)
        cb("Error while receiving a response: " .. tostring(err))
      end)
      res:on("data", function (chunk)
        output = output .. chunk
      end)
      res:on("end", function ()
        res:destroy()
        cb(output)
      end)
    end)
    req:on("error", function(err)
      cb("Error while sending a request: " .. tostring(err))
    end)
    req:done()
end

fs.readFile("param.json", function (err, data)
  if (err) then return end
  value = JSON.parse(data)

  poll = value['poll'] or 5000
  host = value['host'] or "localhost"
  port = value['port'] or 9200

  print("_bevent:ElasticSearch plugin up : version 1.0|t:info|tags:elasticsearch,lua,plugin")

  timer.setInterval(poll, function ()

    doreq(host, port, "/_cluster/health", function(body)
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


end)


