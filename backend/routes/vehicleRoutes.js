const express = require('express');
const vehicleController = require('../controllers/vehicleController');

const router = express.Router();

router.get('/available-for-request/:requestId', vehicleController.getAvailableVehiclesForRequest);

router.route('/')
    .get(vehicleController.getAllVehicles)
    .post(vehicleController.createVehicle);

router.route('/:id')
    .get(vehicleController.getVehicle)
    .put(vehicleController.updateVehicle)
    .delete(vehicleController.deleteVehicle);

module.exports = router;
