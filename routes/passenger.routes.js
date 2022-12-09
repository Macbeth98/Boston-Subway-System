const router = require("express").Router();

const passengerController = require("../controllers/passenger.controller");

// Passenger module Default route.
router.get("/", (req, res) => {
  return res.json({
    status: true,
    message: "BSS: Passenger Module.",
    timestamp: new Date()
  })
})


router.post('/create', passengerController.registerAsPassenger);

router.post('/edit', passengerController.editPassengerData);

router.get('/get', passengerController.getPassengers);

router.post('/delete', passengerController.deletePassenger);


module.exports = router;