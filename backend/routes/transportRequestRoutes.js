const express = require('express');
const transportRequestController = require('../controllers/transportRequestController');

const router = express.Router();

router.route('/')
    .get(transportRequestController.getAllTransportRequests)
    .post(transportRequestController.createTransportRequest);

router.route('/:id')
    .get(transportRequestController.getTransportRequest)
    .put(transportRequestController.updateTransportRequest)
    .delete(transportRequestController.deleteTransportRequest);

router.patch('/:id/assign', transportRequestController.assignDriverAndVehicle);
router.patch('/:id/status', transportRequestController.updateTransportRequestStatus);

module.exports = router;
