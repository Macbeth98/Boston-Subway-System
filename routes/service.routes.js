const router = require("express").Router();

const serviceController = require("../controllers/service.controller");

// Service module Default route.
router.get("/", (req, res) => {
  return res.json({
    status: true,
    message: "BSS: Service Module.",
    timestamp: new Date()
  })
})


router.post("/passengers/travelled/in/route", serviceController.getPassengersTravelledInARoute);

router.get("/routes/used/passenger", serviceController.getMostRoutesUsedbyPassenger);

router.get("/passenger/travel/history", serviceController.getPassengerTravelHistory);

router.get("/passenger/tickets", serviceController.getPassengerTicketsWithLuggageData);

router.get("/trams/route/get", serviceController.getTramsWithCargoDataPerRoute);

router.get("/station/busy/day", serviceController.getStationBusyDay);

router.get("/trams/route/day", serviceController.getTramsForRouteForADay);

router.get("/routes/per/station", serviceController.getRoutesForGivenStation);

router.get("/stations/for/station", serviceController.getCompatibaleStationsForGivenStation);

router.get("/route/data/get", serviceController.getRouteDataForGivenRoute);

router.get("/trams/for/source/destination", serviceController.getTramsForGivenSourceAndDestination);



module.exports = router;


