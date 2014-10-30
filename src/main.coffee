tts = require('node-tts-api')
http = require('http')
fs = require('fs')
_ = require('underscore')
mkdirp = require('mkdirp')

assets = require('./assets.coffee')

console.log "Creating assets folder: ./assets"
mkdirp './assets', (err) ->
    if err
      console.error err
    else
      console.log "ok"

downloadAsset = (url, path) ->
  file = fs.createWriteStream( path )
  request = http.get url, (response) ->
    console.log "Writing asset to file: #{path}"
    response.pipe( file )


_.each assets, (value, key) ->
  console.log "Converting asset: ", key
  tts.getSpeech value, (error, link) =>   
    if error
      console.log "Error: converting asset::#{key}", error
    else
      console.log(link)
      downloadAsset( link, "./assets/#{key}.mp3")

console.log "end"