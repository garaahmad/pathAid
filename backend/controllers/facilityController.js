const Facility = require('../models/facilityModel');

exports.getAllFacilities = async (req, res, next) => {
    try {
        const facilities = await Facility.find();
        res.status(200).json(facilities);
    } catch (err) { next(err); }
};

exports.getFacility = async (req, res, next) => {
    try {
        const facility = await Facility.findOne({ id: req.params.id });
        if (!facility) return res.status(404).json({ message: 'Facility not found' });
        res.status(200).json(facility);
    } catch (err) { next(err); }
};

exports.createFacility = async (req, res, next) => {
    try {
        const doc = await Facility.create(req.body);
        res.status(201).json(doc);
    } catch (err) {
        next(err);
    }
};

exports.updateFacility = async (req, res, next) => {
    try {
        const doc = await Facility.findOneAndUpdate({ id: req.params.id }, req.body, { new: true, runValidators: true });
        if (!doc) return res.status(404).json({ message: 'Facility not found' });
        res.status(200).json(doc);
    } catch (err) { next(err); }
};

exports.deleteFacility = async (req, res, next) => {
    try {
        const doc = await Facility.findOneAndDelete({ id: req.params.id });
        if (!doc) return res.status(404).json({ message: 'Facility not found' });
        res.status(204).send();
    } catch (err) { next(err); }
};
