const mongoose = require('mongoose');
const { getNextId } = require('./counterModel');

const VehicleSchema = new mongoose.Schema({
    id: { type: Number, unique: true },
    code: { type: String, required: true, unique: true },
    capacity: { type: Number, required: true },
    status: { type: String, enum: ['ACTIVE', 'IN_SERVICE', 'MAINTENANCE'], default: 'ACTIVE' },
    approvalStatus: { type: String, enum: ['PENDING', 'APPROVED', 'REJECTED'], default: 'PENDING' }
}, { timestamps: true });

VehicleSchema.pre('save', async function () {
    if (this.isNew && !this.id) {
        this.id = await getNextId('vehicle');
    }
});

const Vehicle = mongoose.models.Vehicle || mongoose.model('Vehicle', VehicleSchema);
module.exports = Vehicle;
