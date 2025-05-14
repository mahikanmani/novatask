// server.js
const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

app.get('/', (req, res) => {
  res.send('hello from Dockerized Node.js App!');
});

app.listen(PORT, '0.0.0.0', () => {
  console.log('Server is running on http://localhost:${PORT}');
});
