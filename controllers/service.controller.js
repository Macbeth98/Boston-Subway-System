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
      count: routes.length,
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
      count: history.length,
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
      count: tickets.length,
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
      count: trams.length,
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
      count: trams.length,
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
      count: routes.length,
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
      count: stations.length,
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
    count: routeData.length,
    routeData
  })
}

const getTramsForGivenSourceAndDestination = async (req, res) => {
  try {

    let { start_station_id, end_station_id } = req.query;

    if(!start_station_id) throw ({message: "Start Point is not given."});
    if(!end_station_id) throw ({message: "End point is not given."});

    let queryString = `call routes_for_station(${start_station_id})`;

    let startRoutes = await executeSQLString(queryString);
    if(startRoutes.length === 0) throw ({message: "There is no route with the given station."});

    queryString = `call routes_for_station(${end_station_id})`;

    let endRoutes = await executeSQLString(queryString);


    
  } catch (e) {
    errorCatcher(req, res, e);
    return ;
  }
}


module.exports = {
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

