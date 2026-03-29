const mongoose = require('mongoose');
const { getNextId } = require('./counterModel');

const FacilitySchema = new mongoose.Schema({
    id: { type: Number, unique: true },
    name: { type: String, required: true },
    type: { type: String, enum: ['CLINIC', 'HOSPITAL', 'LAB'], required: true },
    area: { type: String, required: true },
    city: { type: String, required: true },
    approvalStatus: { type: String, enum: ['PENDING', 'APPROVED', 'REJECTED'], default: 'PENDING' }
}, { timestamps: true });

FacilitySchema.pre('save', async function () {
    if (this.isNew && !this.id) {
        this.id = await getNextId('facility');
    }
});

const Facility = mongoose.models.Facility || mongoose.model('Facility', FacilitySchema);
module.exports = Facility;
