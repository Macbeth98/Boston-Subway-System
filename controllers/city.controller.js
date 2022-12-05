/**
 * City Controller. CRUD for cities in the MBTA system.
*/

const httpStatusCodes = require("../utils/httpStatusCodes");
const { executeSQLModel, executeSQLString } = require("../model/db");
const { City } = require("../model/model.js");

const createCity = async (req, res) => {
  try {

    let { cityName, stateName } = req.body;

    if(!cityName) throw ({message: "City must be given."});
    if(!stateName) throw ({message: "State must be given."});

    const city = new City({cityName, stateName});

    let queryString = `insert into city set ?`

    const result = await executeSQLModel(queryString, city);

    return res.json({
      status: true,
      message: "Successfully created a New City.",
      result
    })

  } catch(e) {
    console.error(e);
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

    let { cityId, cityName, stateName } = req.query;

    let queryString = 'SELECT * from city';

    if(cityId) {
      queryString = queryString + ` where city_code = ${cityId}`;
    } else if (cityName) {
      queryString = queryString + ` where city_name = ${cityName}`;
    } else if (stateName) {
      queryString = queryString + ` where state_name = ${stateName}`;
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