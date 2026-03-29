const TransportRequest = require('../models/transportRequestModel');

exports.getAllTransportRequests = async (req, res, next) => {
    try {
        const docs = await TransportRequest.find().sort({ createdAt: -1 });
        res.status(200).json(docs);
    } catch (err) { next(err); }
};

exports.getTransportRequest = async (req, res, next) => {
    try {
        const doc = await TransportRequest.findOne({ id: req.params.id });
        if (!doc) return res.status(404).json({ message: 'Request not found' });
        res.status(200).json(doc);
    } catch (err) { next(err); }
};

exports.createTransportRequest = async (req, res, next) => {
    try {
        const doc = await TransportRequest.create(req.body);
        res.status(201).json(doc);
    } catch (err) { next(err); }
};

exports.updateTransportRequest = async (req, res, next) => {
    try {
        const doc = await TransportRequest.findOneAndUpdate({ id: req.params.id }, req.body, { new: true });
        if (!doc) return res.status(404).json({ message: 'Request not found' });
        res.status(200).json(doc);
    } catch (err) { next(err); }
};

exports.assignDriverAndVehicle = async (req, res, next) => {
    try {
        const { driverId, vehicleId } = req.body;
        const doc = await TransportRequest.findOneAndUpdate(
            { id: req.params.id },
            { driverId, vehicleId, assignedAt: new Date(), status: 'ACCEPTED' },
            { new: true }
        );
        if (!doc) return res.status(404).json({ message: 'Request not found' });
        res.status(200).json(doc);
    } catch (err) { next(err); }
};

exports.updateTransportRequestStatus = async (req, res, next) => {
    try {
        const { status } = req.body;
        const doc = await TransportRequest.findOneAndUpdate(
            { id: req.params.id },
            { status },
            { new: true }
        );
        if (!doc) return res.status(404).json({ message: 'Request not found' });
        res.status(200).json(doc);
    } catch (err) { next(err); }
};

exports.deleteTransportRequest = async (req, res, next) => {
    try {
        const doc = await TransportRequest.findOneAndDelete({ id: req.params.id });
        if (!doc) return res.status(404).json({ message: 'Request not found' });
        res.status(204).send();
    } catch (err) { next(err); }
};
