const mongoose = require('mongoose');

const CounterSchema = new mongoose.Schema({
    _id: String,
    seq: { type: Number, default: 0 },
});

const Counter = mongoose.models.Counter || mongoose.model('Counter', CounterSchema);

async function getNextId(name) {
    const counter = await Counter.findByIdAndUpdate(
        name,
        { $inc: { seq: 1 } },
        { new: true, upsert: true }
    );
    return counter.seq;
}

module.exports = { Counter, getNextId };
