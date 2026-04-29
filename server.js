require('dotenv').config();
const express = require('express');
const cors = require('cors');

const app = express();

app.use((req, res, next) => {
    console.log('Incoming request:', req.method, req.url);
    next();
});

app.use(cors({
    origin: '*',
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization', 'Accept']
}));
app.use(express.json());

// Routes
const contentRoutes = require('./routes/contentRoutes');
app.use('/api/content', contentRoutes);

app.get('/api/health', (req, res) => {
    res.json({ status: 'OK', message: 'Backend is running' });
});

const PORT = process.env.PORT || 5000;
const server = app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});

process.on('uncaughtException', (err) => {
    console.error('CRITICAL ERROR - Uncaught Exception:', err);
});

process.on('unhandledRejection', (reason, promise) => {
    console.error('CRITICAL ERROR - Unhandled Rejection:', reason);
});
