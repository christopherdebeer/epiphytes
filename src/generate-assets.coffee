tts = require('node-tts-api')
http = require('http')
fs = require('fs')
_ = require('underscore')
mkdirp = require('mkdirp')

assets = require('./assets.coffee')

console.log "Creating assets folder: ./public/assets"
mkdirp './public/assets', (err) ->
    if err
      console.error err
    else
      console.log "ok"

downloadAsset = (url, path) ->
  file = fs.createWriteStream( path )
  request = http.get url, (response) ->
    console.log "Writing asset to file: #{path}"
    response.pipe( file )

saveAssetJSONP = ->
  fs.writeFile "./public/assets.js", "var RT023_ASSETS = #{ JSON.stringify(assets) };", (err) ->
    if err
        console.log( err )
    else
        console.log( "Assets.js file was saved!" )

_.each assets, (asset, key) ->
  console.log "Converting asset: ", key
  tts.getSpeech asset.text, (error, link) =>   
    if error
      console.log "Error: converting asset::#{key}", error
    else
      console.log(link)
      downloadAsset( link, "./public/assets/#{key}.mp3")
      assets[key].url = "/assets/#{key}.mp3"
      assets[key].id = key
      saveAssetJSONP()

console.log "end"
