tts = require('node-tts-api')
http = require('http')
fs = require('fs')
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
    response.pipe( file )


for asset of assets
  console.log "Converting asset: ", asset
  tts.getSpeech assets[asset], (error, link) ->
    if error
      console.log "Error: converting asset::#{asset}", error
    else
      console.log(link)
      downloadAsset( link, "./assets/#{asset}.mp3")

console.log "end"