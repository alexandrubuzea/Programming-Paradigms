const express = require('express')
const app = express()
const bodyParser = require("body-parser");
const port = process.env.PORT || 3000;

app.use(bodyParser.json());
app.set('port', port);

app.get('/api/evens', async (req, res) => {
    const {n} = req.body

    if (n === undefined || typeof(n) !== 'number') {
        res.status(400).json({evens: []})
        return
    }

    res.status(200).json({evens: Array.from(Array(n)).map((_, i)=> 2 * i + 2)})
})

app.listen(port, async (err) => {
    if (err) {
        console.error(err);
    } else {
        console.info(`Server is listening on port ${port}`);
    }
});