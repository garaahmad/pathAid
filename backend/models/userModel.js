const mongoose = require('mongoose');
const { getNextId } = require('./counterModel');
const bcrypt = require('bcryptjs');

const UserSchema = new mongoose.Schema({
    id: { type: Number, unique: true },
    fName: { type: String, required: true },
    lName: { type: String, required: true },
    email: { type: String, unique: true, required: true },
    password: { type: String, required: true, select: false },
    phoneNumber: { type: String, required: true, unique: true },
    age: { type: Number, required: true },
    role: { type: String, enum: ['DRIVER', 'SENDER', 'ADMIN', 'COORDINATOR'], default: 'DRIVER' },
    facilityId: { type: Number },
    enabled: { type: Boolean, default: true }
}, { timestamps: true });

UserSchema.pre('save', async function () {
    if (this.isNew && !this.id) {
        this.id = await getNextId('user');
    }
    if (this.isModified('password')) {
        this.password = await bcrypt.hash(this.password, 12);
    }
});

UserSchema.methods.correctPassword = async function(candidatePassword, userPassword) {
    return await bcrypt.compare(candidatePassword, userPassword);
};

const User = mongoose.models.User || mongoose.model('User', UserSchema);
module.exports = User;
