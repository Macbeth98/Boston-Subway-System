const router = require("express").Router();

const ticketController = require("../controllers/ticket.controller");

// Ticker module Default route.
router.get("/", (req, res) => {
  return res.json({
    status: true,
    message: "BSS: Ticket Module.",
    timestamp: new Date()
  })
})


router.post("/create", ticketController.createNewTicket);

router.get("/get", ticketController.getTickets);

router.post("/luggage/edit", ticketController.updateLuggageForATicket);

module.exports = router;


