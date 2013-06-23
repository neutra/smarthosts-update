URL = "http://smarthosts.googlecode.com/svn/trunk/hosts"
FILE = "c:/windows/system32/drivers/etc/hosts"

load = (callback) ->
	http = require 'http'
	onConnect = (res) ->
		unless res.statusCode is 200
			return callback "bad status: #{res.statusCode}" 
		bytes = 0
		buffers = []
		res.on 'data',(buf) ->
			buffers.push buf
			bytes += buf.length
		res.on 'end',->
			all = ""
			if bytes 
				all = new Buffer bytes
				i = 0
				for buf in buffers
					buf.copy all, i, 0, buf.length
					i += buf.length
				all = all.toString 'utf8'
			all = all.replace /127.0.0.1\tlocalhost\s*/, ''
			all = all.replace /#SmartHosts START\s*/, ''
			all = all.replace /\s*#SmartHosts END\s*/, ''
			all = '#SmartHosts AutoUpdate START\r\n\r\n' + all + '\r\n\r\n#SmartHosts AutoUpdate END\r\n'
			callback null, all
	http.get(URL,onConnect).on 'error',callback

update = (text,callback) ->
	fs = require 'fs'
	old = fs.readFileSync FILE,'utf8'
	old = old.replace /\s*#SmartHosts AutoUpdate START[\s\S]+#SmartHosts AutoUpdate END\s*/, ''
	fs.writeFileSync FILE, old + '\r\n\r\n\r\n' + text
	callback null

do ->
	load (err,text) ->
		return console.log err if err
		update text, (err) ->
		console.log if err then err else 'ok'