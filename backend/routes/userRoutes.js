const express = require('express');
const userController = require('../controllers/userController');

const router = express.Router();

router.get('/drivers/available-for-request/:requestId', userController.getAvailableDriversForRequest);

router.route('/')
    .get(userController.getAllUsers)
    .post(userController.createUser);

router.route('/:id')
    .get(userController.getUser)
    .put(userController.updateUser)
    .delete(userController.deleteUser);

module.exports = router;
