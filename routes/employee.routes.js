const router = require("express").Router();

const employeeController = require("../controllers/employee.controller");

// Employee module Default route.
router.get("/", (req, res) => {
  return res.json({
    status: true,
    message: "BSS: Employee Module.",
    timestamp: new Date()
  })
})


router.post('/create', employeeController.addEmployee);

router.post('/edit', employeeController.editEmployee);

router.get('/get', employeeController.getEmployee);

router.post('/delete', employeeController.deleteEmployee);


module.exports = router;