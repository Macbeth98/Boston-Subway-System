/**
 * Employee Controller. The Employee operates the Boston Subway System. 
 * There are three types of Employees -> Manager, Admin staff, Motorman.
*/

const httpStatusCodes = require("../utils/httpStatusCodes");
const { executeSQLModel, executeSQLString } = require("../model/db");
const { Employee, AdminstrativeStaff, Manager, Motorman, validateDate } = require("../model/model.js");
const e = require("express");



const addEmployee = async (req, res) => {
  try {

    let data = req.body;

    if(!(data.admin_staff || data.manager || data.motoman)) {
      throw ({message: "The employee type is not given."});
    }

    var employeeType;
    var table;

    data.validate = true;

    if(data.admin_staff) {
      employeeType = new AdminstrativeStaff(data);
      table = "administrative_staff";
    } else if (data.manager) {
      employeeType = new Manager(data);
      table = "manager";
    } else {
      employeeType = new Motorman(data);
      table = "motorman"
    }

    const employee  =  new Employee(data);

    let queryString = "insert into employees set ?";

    let employeeRes = await executeSQLModel(queryString, employee);

    employee.employee_id = employeeRes.insertId;

    queryString = "insert into " + table + " set ?";

    employeeType.employee_id = employee.employee_id;

    let employeeSubData = {...employeeType};

    for (const prop in employee) {
      if(prop === "employee_id") continue;

      delete employeeSubData[prop];
    }

    // if(data.admin_staff) {
    //   employeeSubData.station_id = employeeType.station_id;
    //   employeeSubData.staff_type = employeeType.staff_type;
    //   employeeSubData.responsibilities = employeeType.responsibilities;
    // } else {
      
    // }

    let employeeTypeRes = await executeSQLModel(queryString, employeeSubData);

    return res.json({
      status: true,
      message: "Employee Created.",
      employee,
      employeeType
    })

  } catch (e) {
    console.error(e);
    return res.status(httpStatusCodes.BAD_REQUEST).json({
      message: e.message,
      error: e
    })
  }
}


const editEmployee = async (req, res) => {
  try {

    let data = req.body;

    const employee = new Employee(data);

    if(!employee.employee_id) throw ({message: "Employee Id is not given."});

    let setQuery = "set "

    let commaRequired = false;

    if(employee.employee_dob) {
      validateDate(employee.employee_dob);
    }

    for (const prop in employee) {
      if(!employee[prop]) continue ;

      let setComma = commaRequired? ", " : "";
      setQuery = setQuery + setComma + ` ${prop} = ` + employee[prop];
      commaRequired = true;
    }

    let queryString = "update employees " + setQuery + " where employee_id=" + employee.employee_id;

    let result = await executeSQLString(queryString);

    return res.json({
      status: true,
      message: "Employee data updated Successfully.",
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


const getEmployee = async (req, res) => {
  try {

    let { employee_id } = req.query;

    let queryString = "select * from employees"

    if(employee_id) {
      queryString = queryString + " where employee_id = " + employee_id;
    }

    let employees = await executeSQLString(queryString);

    return res.json({
      status: true,
      count: employees.length,
      employees
    })

  } catch (e) {
    console.error(e);
    return res.status(httpStatusCodes.BAD_REQUEST).json({
      message: e.message,
      error: e
    })
  }
}


const deleteEmployee = async (req, res) => {
  try {

    let { employee_id } = req.body;

    let queryString = "delete from employees where employee_id = " + employee_id;

    let result = await executeSQLString(queryString);

    return res.json({
      status: true,
      message: "Employee record Deleted.",
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
  addEmployee,
  editEmployee,
  getEmployee,
  deleteEmployee
}