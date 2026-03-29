const User = require('../models/userModel');

exports.getAllUsers = async (req, res, next) => {
    try {

        const users = await User.find().select('-password');
        res.status(200).json(users);
    } catch (err) { next(err); }
};

exports.getUser = async (req, res, next) => {
    try {
        const user = await User.findOne({ id: req.params.id }).select('-password');
        if (!user) return res.status(404).json({ message: 'User not found' });
        res.status(200).json(user);
    } catch (err) { next(err); }
};

exports.createUser = async (req, res, next) => {
    try {
        const user = await User.create(req.body);
        user.password = undefined;
        res.status(201).json(user);
    } catch(err) { next(err); }
};

exports.updateUser = async (req, res, next) => {
    try {
        const user = await User.findOneAndUpdate({ id: req.params.id }, req.body, { new: true }).select('-password');
        if (!user) return res.status(404).json({ message: 'User not found' });
        res.status(200).json(user);
    } catch (err) { next(err); }
};

exports.deleteUser = async (req, res, next) => {
    try {
        const user = await User.findOneAndDelete({ id: req.params.id });
        if (!user) return res.status(404).json({ message: 'User not found' });
        res.status(204).send();
    } catch (err) { next(err); }
};

exports.getAvailableDriversForRequest = async (req, res, next) => {
    try {
        const drivers = await User.find({ role: 'DRIVER', enabled: true }).select('-password');
        res.status(200).json(drivers);
    } catch (err) { next(err); }
};
