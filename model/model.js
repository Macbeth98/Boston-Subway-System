const validateDate = async (dateString) => {
  return new Promise(async (resolve, reject) => {
    let date = new Date(dateString);
    if(date.getTime() >= new Date().getTime()) {
      throw ({message: "Cannot give future date."})
    }
    return date;
  })
}




// constructor for City
class City {
  constructor(city) {
    this.city_code = city.city_code;
    this.city_name = city.city_name,
      this.state_name = city.state_name;
  }
}


// constructor for Ticket
class Ticket {
  constructor(ticket) {

    if (ticket.validate) {
      if (!ticket.route_id)
        throw ({ message: "route_id must be given." });
      if (!ticket.passenger_id)
        throw ({ message: "passenger_id must be given." });
      if (!ticket.tram_id)
        throw ({ message: "Tram is not given." });
      if (!ticket.employee_id)
        throw ({ message: "Employee Id is not given." });
    }

    this.ticket_id = ticket.ticket_id;
    this.date_time = ticket.date_time;
    this.station_id = ticket.station_id;
    this.route_id = ticket.route_id;
    this.passenger_id = ticket.passenger_id;
    this.tram_id = ticket.tram_id;
    this.employee_id = ticket.employee_id;
    this.luggage = ticket.luggage;
  }
}

// constructor for Luggage.
class Luggage {
  constructor(luggage) {

    if (luggage.validate) {
      if (!luggage.luggage_type)
        throw ({ message: "Luggage Type is not given." });
      if (!luggage.luggage_weight)
        throw ({ message: "Luggage Weight is not given." });
      if (!luggage.tram_id)
        throw ({ message: "tram_id of the luggage is not given." });
    }

    this.luggage_id = luggage.luggage_id;
    this.luggage_type = luggage.luggage_type;
    this.luggage_weight = luggage.luggage_weight;
    this.tram_id = luggage.tram_id;
    this.ticket_id = luggage.ticket_id;
  }
}


class Passenger {
  constructor(passenger) {

    if (passenger.validate) {
      if (!passenger.passenger_name)
        throw ({ message: "Name is not given." });
      if (!passenger.passenger_email)
        throw ({ message: "Email is not given." });
      if (!passenger.passenger_dob)
        throw ({ message: "Date of Birth is not given." });

      validateDate(passenger.passenger_dob);

      if (!passenger.passenger_sex)
        throw ({ message: "The passenger sex is not given." });
      if (!passenger.passenger_address)
        throw ({ message: "The passenger address is not given." });
    }

    this.passenger_id = passenger.passenger_id;
    this.passenger_name = passenger.passenger_name;
    this.passenger_email = passenger.passenger_email;
    this.passenger_dob = passenger.passenger_dob;
    this.passenger_sex = passenger.passenger_sex;
    this.passenger_address = passenger.passenger_address;
  }
}


class Employee {
  constructor(employee) {

    if (employee.validate) {
      employee.employee_salary = Number(employee.employee_salary);

      if (!employee.employee_name)
        throw ({ message: "Employee name is not given." });
      if (!employee.employee_dob)
        throw ({ message: "Employee DOB is not given." });
      if (!employee.employee_sex)
        throw ({ message: "Employee Sex is not given." });
      if (!employee.employee_address)
        throw ({ message: "Employee Address is not given." });
      if (!employee.employee_shift_timings)
        throw ({ message: "Employee Shift timings are not given." });
      if (!(employee.employee_salary > 0))
        throw ({ message: "Employee salary is not given." });
    }

    this.employee_id = employee.employee_id;
    this.employee_name = employee.employee_name;
    this.employee_dob = employee.employee_dob;
    this.employee_sex = employee.employee_sex;
    this.employee_address = employee.employee_address;
    this.employee_shift_timings = employee.employee_shift_timings;
    this.employee_salary = employee.employee_salary;
  }
}

class AdminstrativeStaff extends Employee {
  constructor (adminStaff) {

    super(adminStaff);

    if(!adminStaff.station_id) throw ({message: "Station Id is not given."});

    this.station_id = adminStaff.station_id;
    this.staff_type = adminStaff.staff_type;
    this.responsibilities = adminStaff.responsibilities;

  }
}

class Manager extends Employee {
  constructor (manager) {

    super (manager);

    if(!manager.station_id) throw ({message: "Station Id is not given."});
    this.station_id = manager.station_id;
  }
}

class Motorman extends Employee {
  constructor (motorman) {

    super (motorman);

    if(!motorman.license_id) throw ({message: "License Id is not given."});
    if(!motorman.experience) throw ({message: "Experience is not given."});

    this.license_id = motorman.license_id;
    this.tram_experience = motorman.tram_experience;
  }
}




module.exports = {
  validateDate,
  City,
  Ticket,
  Luggage,
  Passenger,
  Employee,
  AdminstrativeStaff,
  Manager,
  Motorman
}