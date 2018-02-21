const express = require('express')
const app = express()

app.get('/', function (req, res) {
  res.send(`Hello World! -- ${process.env.NODE || 'undefind'}`)
})

app.get('/health', function (req, res) {
  res.send('ok.')
})

app.get('/metadata', function (req, res) {
  res.send(JSON.stringify({
    "version": "v0.0.1",
    "author": "kerry",
    "node": `${process.env.NODE || "undefind"}`
  }))
})

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})
