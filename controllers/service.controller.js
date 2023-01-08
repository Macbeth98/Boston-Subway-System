/**
 * Employee Controller. The Employee operates the Boston Subway System. 
 * There are three types of Employees -> Manager, Admin staff, Motorman.
*/

const httpStatusCodes = require("../utils/httpStatusCodes");
const { executeSQLModel, executeSQLString } = require("../model/db");
const { Employee, AdminstrativeStaff, Manager, Motorman, validateDate } = require("../model/model.js");


const errorCatcher = async (req, res, error) => {
  console.error(error);
  return res.status(httpStatusCodes.BAD_REQUEST).json({
    message: error.message,
    error
  })
}


const getRoutes = async (req, res) => {
  try {

    let queryString = 'select * from route';

    let routes = await executeSQLString(queryString);

    return res.json({
      status: true,
      routes
    })
    
  } catch (e) {
    errorCatcher(req, res, e);
    return ;
  }
}


const getStations = async (req, res) => {
  try {
    
    let queryString = 'select * from station order by station_id';

    let stations = await executeSQLString(queryString);

    return res.json({
      status: true,
      stations
    })

  } catch (e) {
    errorCatcher(req, res, e);
    return ;
  }
}

const getTrams = async (req, res) => {
  try {
    
    let queryString = 'select * from tram as t inner join route as r on t.route_id = r.route_id order by tram_id';

    let trams = await executeSQLString(queryString);

    return res.json({
      status: true,
      trams
    })

  } catch (e) {
    errorCatcher(req, res, e);
    return ;
  }
}


const getPassengersTravelledInARoute = async (req, res) => {
  try {

    let route_id = req.query.route_id;

    if(!route_id) throw ({message: "Route_id is not given."});

    let queryString = `call passengerroute(${route_id})`;

    let route = await executeSQLString(queryString);

    return res.json({
      status: true,
      route
    })
    
  } catch (e) {
    errorCatcher(req, res, e);
  }
}


const getMostRoutesUsedbyPassenger = async (req, res) => {
  try {

    let queryString = "call most_routes_used()";

    let routes = await executeSQLString(queryString);

    return res.json({
      status: true,
      routes
    })

  } catch (e) {
    errorCatcher(req, res, e);
  }
}


const getPassengerTravelHistory = async (req, res) => {
  try {

    let passenger_id = req.query.passenger_id;

    if(!passenger_id) throw ({message: "Passenger id is not given."})

    let queryString = `call passenger_travel_history(${passenger_id})`;

    let history = await executeSQLString(queryString);

    return res.json({
      status: true,
      history
    })
    
  } catch (e) {
    errorCatcher(req, res, e);
    return ;
  }
}

const getPassengerTicketsWithLuggageData = async (req, res) => {
  try {
    
    let passenger_id = req.query.passenger_id;

    if(!passenger_id) throw ({message: "Passenger id is not given."})

    let queryString = `call get_passenger_tickets_with_luggage_data(${passenger_id})`;

    let tickets = await executeSQLString(queryString);

    return res.json({
      status: true,
      tickets
    })

  } catch (e) {
    errorCatcher(req, res, e);
    return;
  }
}

const getTramsWithCargoDataPerRoute = async (req, res) => {
  try {
    let route_id = req.query.route_id;

    if(!route_id) route_id = null;

    let queryString = `call get_trams_with_cargo_data(${route_id})`;

    let trams = await executeSQLString(queryString);

    return res.json({
      status: true,
      trams
    })

  } catch (e) {
    errorCatcher(req, res, e)
  }
}

const getStationBusyDay = async (req, res) => {
  try {
    
    let station_id = req.query.station_id;

    if(!station_id) throw ({message: "station id not given."});

    let queryString = `call stationbusyday(${station_id})`;

    let data = await executeSQLString(queryString);

    return res.json({
      status: true,
      data
    })

  } catch (e) {
    errorCatcher(req, res, e);
    return ;
  }
}


const getTramsForRouteForADay = async (req, res) => {
  try {
    
    let { route_id, day } = req.query;

    if(!route_id) throw ({message: "Route is not given."});
    if(!day) throw ({message: "day is not given."});

    let queryString = `call tramsforroute(${route_id}, ${day})`;

    let trams = await executeSQLString(queryString);

    return res.json({
      status: true,
      trams
    })

  } catch (e) {
    errorCatcher(req, res, e);
    return ;
  }
}


const getRoutesForGivenStation =  async (req, res) => {
  try {
    let station_id = req.query.station_id;

    if(!station_id) throw ({message: "Station_id given is not valid"});

    let queryString = `call routes_for_station(${start_station_id})`;

    let routes = await executeSQLString(queryString);

    return res.json({
      status: true,
      routes
    })

  } catch (e) {
    errorCatcher(req, res, e);
    return ;
  }
}

const getCompatibaleStationsForGivenStation = async (req, res) => {
  try {
    
    let station_id = req.query.station_id;

    if(!station_id) throw ({message: "Station_id given is not valid"});

    let queryString = `call get_stations_for_given_station(${station_id})`;

    let stations = await executeSQLString(queryString);

    return res.json({
      status: true,
      stations
    })

  } catch (e) {
    errorCatcher(req, res, e);
    return ;
  }
}


const getRouteDataForGivenRoute = async (req, res) => {
  let route_id = req.query.route_id;

  if(!route_id) throw ({message: "Route Id is not given."});

  let queryString = `call get_route_data_for_route(${route_id})`

  let routeData = await executeSQLString(queryString);

  return res.json({
    status: true,
    routeData
  })
}

const getTramsForGivenSourceAndDestination = async (req, res) => {
  try {

    let { start_station_id, end_station_id } = req.query;

    if(!start_station_id) throw ({message: "Start Point is not given."});
    if(!end_station_id) throw ({message: "End point is not given."});

    let queryString = `call get_tram_for_given_start_end_stations(${start_station_id}, ${end_station_id})`;

    let trams = await executeSQLString(queryString);
    
    return res.json({
      status: true,
      trams
    })

    
  } catch (e) {
    errorCatcher(req, res, e);
    return ;
  }
}


module.exports = {
  getRoutes,
  getStations,
  getTrams,
  getPassengersTravelledInARoute,
  getMostRoutesUsedbyPassenger,
  getPassengerTravelHistory,
  getPassengerTicketsWithLuggageData,
  getTramsWithCargoDataPerRoute,
  getStationBusyDay,
  getTramsForRouteForADay,
  getRoutesForGivenStation,
  getCompatibaleStationsForGivenStation,
  getRouteDataForGivenRoute,
  getTramsForGivenSourceAndDestination
}

