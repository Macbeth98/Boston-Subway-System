/**
 * City Controller. CRUD for cities in the MBTA system.
*/

const httpStatusCodes = require("../utils/httpStatusCodes");
const { executeSQLModel, executeSQLString } = require("../model/db");
const { City } = require("../model/model.js");

const createCity = async (req, res) => {
  try {

    let { city_name, state_name } = req.body;

    if(!city_name) throw ({message: "City must be given."});
    if(!state_name) throw ({message: "State must be given."});

    const city = new City({city_name, state_name});

    let queryString = `insert into city set ?`

    const result = await executeSQLModel(queryString, city);

    return res.json({
      status: true,
      message: "Successfully created a New City.",
      result
    })

  } catch(e) {
    console.error(e);
    if(e.code === "ER_DUP_ENTRY") {
      e.message = "The city and state given already exists."
    }
    return res
    .status(httpStatusCodes.BAD_REQUEST)
    .json({
      message: e.message,
      error: e
    })
  }
}

const getCity = async (req, res) => {
  try {

    let { cityId, city_name, state_name } = req.query;

    let queryString = 'SELECT * from city';

    if(cityId) {
      queryString = queryString + ` where city_code = ${cityId}`;
    } else if (city_name) {
      queryString = queryString + ` where city_name = ${city_name}`;
    } else if (state_name) {
      queryString = queryString + ` where state_name = ${state_name}`;
    }

    const data = await executeSQLString(queryString);

    return res.json({
      status: true,
      count: data.length,
      city: data
    })

  } catch (e) {
    console.error(e);
    return res
    .status(httpStatusCodes.BAD_REQUEST)
    .json({
      message: e.message,
      error: e
    })
  }
}


module.exports = {
  createCity,
  getCity
}