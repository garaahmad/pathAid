const express = require('express');
const facilityController = require('../controllers/facilityController');

const router = express.Router();

router.route('/')
    .get(facilityController.getAllFacilities)
    .post(facilityController.createFacility);

router.route('/:id')
    .get(facilityController.getFacility)
    .put(facilityController.updateFacility)
    .delete(facilityController.deleteFacility);

module.exports = router;
