const express = require('express');
const router = express.Router({ mergeParams: true });

const areaCityMap = {
    'NORTH': ['JABALIA', 'BEIT_LAHIA', 'BEIT_HANOUN'],
    'GAZA': ['WEST_GAZA', 'CENTRAL_GAZA', 'EAST_GAZA', 'GAZA'],
    'CENTER': ['NUSEIRAT', 'MAGHAZI', 'BUREIJ', 'DEIR_AL_BALAH', 'ZAWAIDA'],
    'SOUTH': ['KHAN_YOUNIS', 'RAFAH'],
};

router.get('/cities', (req, res) => {
    const area = req.params.area.toUpperCase();
    const cities = areaCityMap[area];
    if (cities) return res.status(200).json(cities);
    res.status(404).json({ message: 'المنطقة غير موجودة' });
});

module.exports = router;
