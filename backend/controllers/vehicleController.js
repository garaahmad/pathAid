const Vehicle = require('../models/vehicleModel');

exports.getAllVehicles = async (req, res, next) => {
    try {
        const docs = await Vehicle.find();
        res.status(200).json(docs);
    } catch (err) { next(err); }
};

exports.getVehicle = async (req, res, next) => {
    try {
        const doc = await Vehicle.findOne({ id: req.params.id });
        if (!doc) return res.status(404).json({ message: 'Vehicle not found' });
        res.status(200).json(doc);
    } catch (err) { next(err); }
};

exports.getAvailableVehiclesForRequest = async (req, res, next) => {
    try {

        const docs = await Vehicle.find({ status: 'ACTIVE' });
        res.status(200).json(docs);
    } catch (err) { next(err); }
};

exports.createVehicle = async (req, res, next) => {
    try {
        const doc = await Vehicle.create(req.body);
        res.status(201).json(doc);
    } catch (err) { next(err); }
};

exports.updateVehicle = async (req, res, next) => {
    try {
        const doc = await Vehicle.findOneAndUpdate({ id: req.params.id }, req.body, { new: true });
        if (!doc) return res.status(404).json({ message: 'Vehicle not found' });
        res.status(200).json(doc);
    } catch (err) { next(err); }
};

exports.deleteVehicle = async (req, res, next) => {
    try {
        const doc = await Vehicle.findOneAndDelete({ id: req.params.id });
        if (!doc) return res.status(404).json({ message: 'Vehicle not found' });
        res.status(204).send();
    } catch (err) { next(err); }
};
