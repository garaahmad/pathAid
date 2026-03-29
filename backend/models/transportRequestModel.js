const mongoose = require('mongoose');
const { getNextId } = require('./counterModel');

const TransportRequestSchema = new mongoose.Schema({
    id: { type: Number, unique: true },
    driverId: { type: Number },
    vehicleId: { type: Number },
    coordinatorId: { type: Number },
    fromFacilityId: { type: Number, required: true },
    toFacilityId: { type: Number, required: true },
    priority: { type: String, enum: ['NORMAL', 'HIGH', 'URGENT'], required: true },
    status: { type: String, enum: ['PENDING', 'ACCEPTED', 'IN_TRANSIT', 'COMPLETED', 'CANCELLED'], default: 'PENDING' },
    transportTime: { type: Date, required: true },
    patientName: { type: String },
    patientAge: { type: Number },
    notes: { type: String },
    assignedAt: { type: Date }
}, { timestamps: true });

TransportRequestSchema.pre('save', async function () {
    if (this.isNew && !this.id) {
        this.id = await getNextId('transportrequest');
    }
});

const TransportRequest = mongoose.models.TransportRequest || mongoose.model('TransportRequest', TransportRequestSchema);
module.exports = TransportRequest;
