const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;
const APP_NAME = process.env.APP_NAME || 'docker-node-learn';

app.use(express.json());

app.get('/', (req, res) => {
  res.json({
    app: APP_NAME,
    message: 'Hello from Dockerized again 45 Node.js app!hihihihihiihihhihihihihihihi',
    env: process.env.NODE_ENV || 'development'
  });
});

app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

app.post('/api/echo', (req, res) => {
  res.json({
    received: req.body,
    timestamp: new Date().toISOString()
  });
});

app.listen(PORT, () => {
  console.log(`${APP_NAME} listening on port ${PORT}`);
});
