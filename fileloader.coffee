fs = require "fs"
path = require "path"
log = require("debug")("loadfiles")
debug = require("debug")("loadfiles:debug")

module.exports = (basedir, allowedExtension) ->
	return (domain) ->
		basePath = path.normalize "#{basedir}/#{domain}"
		debug "Trying to read files form path: '#{basePath}'"
		data = []
		files = fs.readdirSync basePath
		debug "#{basePath} - files:", files
		files.forEach (file) ->
			extension = path.extname file
			fileName = path.basename file, extension

			# Check if file is an allowed extension.
			return if extension isnt ".#{allowedExtension}"
			filePath = "#{basePath}/#{fileName}"
			debug "Added - filename:'#{fileName}', domain:'#{domain}', extension:'#{extension}', filepath:'#{filePath}'"
			log "Added '#{fileName}' to '#{domain}'"
			data[fileName] = require filePath
		data
