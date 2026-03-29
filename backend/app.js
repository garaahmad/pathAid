const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
const mongoSanitize = require('express-mongo-sanitize');
const xss = require('xss-clean');
const hpp = require('hpp');
const morgan = require('morgan');

const authRoutes = require('./routes/authRoutes');
const AppError = require('./utils/appError');
const globalErrorHandler = require('./controllers/errorController');

const app = express();

app.use(helmet());

app.use(cors());

if (process.env.NODE_ENV === 'development') {
    app.use(morgan('dev'));
}

const limiter = rateLimit({
    max: 100,
    windowMs: 60 * 60 * 1000,
    message: 'Too many requests from this IP, please try again in an hour!'
});
app.use('/api', limiter);

app.use(express.json({ limit: '10kb' }));
app.use(express.urlencoded({ extended: true, limit: '10kb' }));

const facilityRoutes = require('./routes/facilityRoutes');
const vehicleRoutes = require('./routes/vehicleRoutes');
const transportRequestRoutes = require('./routes/transportRequestRoutes');
const userRoutes = require('./routes/userRoutes');
const areaRoutes = require('./routes/areaRoutes');

app.use('/api/v1/users', authRoutes);
app.use('/api/users', userRoutes);
app.use('/api/v1/users', userRoutes);
app.use('/api/facilties', facilityRoutes);
app.use('/api/v1/facilties', facilityRoutes);
app.use('/api/vehicles', vehicleRoutes);
app.use('/api/v1/vehicles', vehicleRoutes);
app.use('/api/transportrequests', transportRequestRoutes);
app.use('/api/v1/transportrequests', transportRequestRoutes);
app.use('/api/:area', areaRoutes);
app.use('/api/v1/:area', areaRoutes);

app.use((req, res, next) => {
    next(new AppError(`Can't find ${req.originalUrl} on this server!`, 404));
});

app.use(globalErrorHandler);

module.exports = app;
