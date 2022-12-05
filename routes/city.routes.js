const router = require("express").Router();

const cityController = require("../controllers/city.controller");

// City module Default route.
router.get("/", (req, res) => {
  return res.json({
    status: true,
    message: "BSS: City Module.",
    timestamp: new Date()
  })
})


router.post("/create", cityController.createCity);

router.get("/get", cityController.getCity);

module.exports = router;


