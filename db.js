const mariadb = require('mariadb')

let db
let init = function() {

    // make sure to import 'db_import/createDB.sql' into your PostgreSQL database first	
	db = mariadb.createPool({
		host: process.env.DB_HOST || "localhost",
		port: process.env.DB_PORT || 3306,
		user: process.env.DB_USER || "webtech-backend",
		password: process.env.DB_PASS || "changeme",
		database: process.env.DB_NAME  || "webtech-backend",
		connectionLimit: 5});
	
};

function getInstance() {
    if (!db) {
        console.log("Db has not been initialized. Please call init first.");
        return;
    }
    return db;
}

module.exports = {
	getInstance,
	init
};
