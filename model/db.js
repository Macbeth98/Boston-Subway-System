const mysql = require("mysql");
const dbConfig = require("../config/db.config.js");


/**
 * createPool allows to connect to DB simulatneously and run queries parallely, making it faster.
 * Instead of using create Connection which allows only once connection.
 */
const connection = mysql.createPool({
  connectionLimit: 30,
  host: dbConfig.HOST,
  user: dbConfig.USER,
  password: dbConfig.PASSWORD,
  database: dbConfig.DB
});


/**
 * This method executes the given sql query string and returns the resulting result from the MySQL DB.
 * Also, this method uses connection.query, where connection represents a MySQL pool. 
 * connection.query() is shortcut for pool.getConnection() -> connection.query() -> connection.release() code flow.
 * Basically, connection.query() handles fetching a connection, executing the query and releasing the connection in one method.
 * 
 * @param {String} queryString: The MySQL query that needs to be executed. 
 * @param model: The model of the table.
 * @returns returns the resulting response from MySQL DB.
 */
const executeSQLModel = (queryString, model) => {
  return new Promise(async (resolve, reject) => {
    connection.query(queryString, model, (err, result) => {
      if(err) {
        return reject(err);
      } else {
        return resolve(result);
      }
    })
    return ;
  })
}


/**
 * This method takes only the query string and executes the SQL string.
 * 
 * @param {String} queryString The MySQL query that needs to be executed.
 * @returns returns the resulting response from MySQL DB.
 */
const executeSQLString = (queryString) => {
  return new Promise(async (resolve, reject) => {
    connection.query(queryString, (err, result) => {
      if(err) {
        return reject(err);
      } else {
        return resolve(result);
      }
    })
    return ;
  })
}

module.exports = {
  executeSQLModel,
  executeSQLString
};
