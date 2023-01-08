/**
 * Passenger Controller. A user can register as a Passenger and create a passenger profile.
*/

const httpStatusCodes = require("../utils/httpStatusCodes");
const { executeSQLModel, executeSQLString } = require("../model/db");
const { Passenger } = require("../model/model.js");



const registerAsPassenger = async (req, res) => {
  try {
    
    let data = req.body;

    const passenger = new Passenger({...data, validate: true});

    let queryString = "insert into passenger set ?";

    let passengerRes = await executeSQLModel(queryString, passenger);

    passenger.passenger_id = passengerRes.insertId

    return res.json({
      status: true,
      message: "Passenger Created.",
      passenger
    })

  } catch (e) {
    console.error(e);
    if(e.code === "ER_DUP_ENTRY") {
      e.message = "The email given already exists."
    }
    return res.status(httpStatusCodes.BAD_REQUEST).json({
      message: e.message,
      error: e
    })
  }
}


const editPassengerData = async (req, res) => {
  try {
    let data = req.body;

    const passenger = new Passenger(data);

    if(!passenger.passenger_id) {
      throw ({message: "Passenger Id must be given."});
    }

    let setQuery = "set "

    let commaRequired = false;

    if(passenger.passenger_dob) {
      let date = new Date(passenger.passenger_dob);
      if(date.getTime() >= new Date().getTime()) {
        throw ({message: "Cannot give future date."})
      }
    }

    for (const prop in passenger) {
      if(!passenger[prop]) continue ;

      let setComma = commaRequired? ", " : "";
      if(prop === "passenger_email") {
        setQuery = setQuery + setComma + ` ${prop} = "${passenger[prop]}"`;
      } else{
        setQuery = setQuery + setComma + ` ${prop} = "${passenger[prop]}"`;
      }
      commaRequired = true;
    }

    let queryString = "update passenger " + setQuery + " where passenger_id=" + passenger.passenger_id;

    let result = await executeSQLString(queryString);

    return res.json({
      status: true,
      message: "Passenger Data Updated.",
      result
    }) 
  } catch (e) {
    console.error(e);

    if(e.code === "ER_DUP_ENTRY") {
      e.message = "The email given already exists."
    }

    return res.status(httpStatusCodes.BAD_REQUEST).json({
      message: e.message,
      error: e
    })
  }
}


const getPassengers = async (req, res) => {
  try {

    let { passenger_id, passenger_email } = req.query;

    let queryString = "select * from passenger";

    if(passenger_id) {
      queryString = queryString + " where passenger_id = " + passenger_id
    } else if (passenger_email) {
      queryString = queryString + ` where passenger_email = "${passenger_email}"`;
    }

    let passengers = await executeSQLString(queryString);

    return res.json({
      status: true,
      count: passengers.length,
      passengers
    })

  } catch (e) {
    console.error(e);

    return res.status(httpStatusCodes.BAD_REQUEST).json({
      message: e.message,
      error: e
    })
  }
}


const deletePassenger = async (req, res) => {
  try {

    let { passenger_id } = req.body;

    if(!passenger_id) throw ({message: "Passenger id must be given."});

    let queryString = "delete from passenger where passenger_id = " + passenger_id;

    let result = await executeSQLString(queryString);

    return res.json({
      status: true,
      message: "Passenger Deleted",
      result
    })

  } catch (e) {
    console.error(e);
    return res.status(httpStatusCodes.BAD_REQUEST).json({
      message: e.message,
      error: e
    })
  }
}




module.exports = {
  registerAsPassenger,
  editPassengerData,
  getPassengers,
  deletePassenger
}