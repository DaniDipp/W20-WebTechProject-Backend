const express = require('express')
const cors = require('cors')
require("./db").init();

const app = express()
const port = process.env.PORT || 80

app.use(cors())
app.use(express.json())

app.use('/products', require('./routes/products'))
app.use('/categories', require('./routes/categories'))
app.use('/users', require("./routes/users"))
app.use('/orders', require("./routes/orders"))
app.use('/ratings', require("./routes/ratings"))


app.get('/', (req, res) => {
	res.send('This page could list the api documentation or serve the frontend page')
})

app.listen(port, () => {
	console.log(`API listening at port ${port}`)
})