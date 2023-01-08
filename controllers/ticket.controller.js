/**
 * Ticket Controller. The passengers needs to buy tickets to use the tram. This controller provides the facility of buying the tickets.
*/

const httpStatusCodes = require("../utils/httpStatusCodes");
const { executeSQLModel, executeSQLString } = require("../model/db");
const { Ticket, Luggage } = require("../model/model.js");


/**
 * Creates a new Ticket with the given data.
 * @param {Ticket} data The data given is of Type Ticket. 
 * @returns returns a new ticket_id.
 */
const createNewTicketPromise = async (data)=> {
  return new Promise(async (resolve, reject)=>{
    try {
      const ticket = new Ticket({...data, validate: true});

      if(data.luggage) {
        var luggage = new Luggage({...data.luggage, tram_id: ticket.tram_id, validate: true});
        ticket.luggage = true;
      } else {
        ticket.luggage = false;
      }
  
      let queryString = `select createTicket(
        ${ticket.station_id}, ${ticket.route_id}, ${ticket.passenger_id}, ${ticket.employee_id}, ${ticket.tram_id}, ${ticket.luggage}
      ) as insertId`;

      console.log(queryString);
  
      let ticketCreated = await executeSQLString(queryString);

      ticket.ticket_id = ticketCreated[0].insertId;

      let luggageResult = null;

      if(ticket.luggage) {
        queryString = "insert into luggage set ?";
        luggage.ticket_id = ticket.ticket_id;

        luggageResult = await executeSQLModel(queryString, luggage);
      }
  
      return resolve({ticket, luggage}); 
    } catch (error) {
      return reject(error);
    }
  })
}


const createNewTicket = async (req, res) => {
  try {

    return res.json({
      status: true,
      message: "Ticket Created Successfully",
      ticket: await createNewTicketPromise(req.body)
    });

  } catch (e) {
    console.error(e);
    return res.status(httpStatusCodes.BAD_REQUEST).json({
      message: e.message,
      error: e
    })
  }
}


const getTickets = async (req, res) => {
  try {

    const conditions = [];
    const values = [];

    const ticket = new Ticket(req.query);

    for (const prop in ticket) {
      if(!ticket[prop]) continue;

      if(prop === "date_time") {
        conditions.push(prop + "LIKE ?");
        values.push("%" + ticket[prop] + "%");

        continue ;
      } else {
        conditions.push(prop + "= ?")
      }

      if(prop === "luggage") {
        values.push(ticket[prop].toLowerCase() === "true"? true: false);
      } else {
        values.push(ticket[prop]);
      }
    }

    let buildQuery = {
      where: conditions.length? conditions.join('AND'): '1',
      values: values
    }

    let queryString = "select * from ticket where " + buildQuery.where;

    const result = await executeSQLModel(queryString, buildQuery.values);

    return res.json({
      status: true,
      count: result.length,
      tickets: result
    })

  } catch (e) {
    console.error(e);
    return res.status(httpStatusCodes.BAD_REQUEST).json({
      message: e.message,
      error: e
    })
  }
}


const updateLuggageForATicket = async (req, res) => {
  try {

    let {ticket_id, luggage_type, luggage_weight} = req.body;

    if(!ticket_id) throw ({message: "Ticket is not given."});

    if(!(luggage_type || luggage_weight)) throw ({message: "Luggage Type or Luggage Weight parameter must be given."})
    
    if(luggage_weight) {
      luggage_weight = Number(luggage_weight);
      if(luggage_weight <  0) throw ({message: "Luggage Weight cannot be negative."});
    }

    let queryString = "Select * from ticket where ticket_id = " + ticket_id;

    let ticketRes = await executeSQLString(queryString);

    if(ticketRes.length === 0) throw ({message: "The ticket given is not found."});

    const ticket = new Ticket(ticketRes[0]);

    if(ticket.luggage && luggage_weight === 0) {
      queryString = "delete from luggage where ticket_id = " + ticket_id;
      let removeLuggage =  await executeSQLString(queryString);

      queryString = "update ticket set luggage = 0 where ticket_id = " + ticket_id;
      await executeSQLString(queryString);

      return res.json({status: true, message: "Luggage removed", result: removeLuggage});
    }

    let setQuery = "set ";

    if(luggage_type) {
      setQuery = setQuery + "luggage_type = " + luggage_type;
    }

    if(luggage_weight) {
      setQuery = luggage_type? setQuery + ", ": setQuery;
      setQuery = setQuery + "luggage_weight = " + luggage_weight
    }

    queryString = "update luggage " + setQuery + " where ticket_id = " + ticket_id;

    let luggageUpdate = await executeSQLString(queryString);

    if(!ticket.luggage) {
      queryString = "update ticket set luggage = 1 where ticket_id = " + ticket_id;
      await executeSQLString(queryString);
    }

    return res.json({
      status: true,
      message: "Updated the Luggage Data.",
      result: luggageUpdate
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
  createNewTicket,
  getTickets,
  updateLuggageForATicket
}