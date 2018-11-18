const express = require('express')
const app = express()

app.get('/todo', function (req, res) {
  res.send('Hello World!')
})

app.get('/todo/health', function (req, res) {
  res.send('ok.')
})

app.get('/todo/metadata', function (req, res) {
  res.send(JSON.stringify({
    "version": "v0.0.1",
    "author": "kerry"
  }))
})

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})
