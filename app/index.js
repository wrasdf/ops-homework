const express = require('express')
const app = express()

app.get('/', (req, res)=> {
  res.send(`Hello World! -- ${process.env.NODE}`)
})

app.get('/health', (req, res)=> {
  res.send(`ok. - ${process.env.NODE}`)
})

app.get('/metadata', (req, res)=> {
  res.send(JSON.stringify({
    "version": "v0.0.1",
    "author": "kerry",
    "node": "`${process.env.NODE}`"
  }))
})

app.listen(3000, ()=> {
  console.log('Example app listening on port 3000!')
})
