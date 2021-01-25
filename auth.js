const jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt')
const { reject } = require('bcrypt/promises')
const { nextTick } = require('process')
const jwtSecret = process.env.JWT_SECRET || "changeme"

module.exports = {
	encryptPassword: (password) => {
		return new Promise((resolve, reject) => {
			bcrypt.hash(password, 10)
				.then(hashedPassword => resolve(hashedPassword))
				.catch(err => reject(err))
		})
	},

	checkPassword: (password, hashedPassword) => {
		return new Promise((resolve, reject) => {
			bcrypt.compare(password, hashedPassword)
				.then(result => resolve(result))
				.catch(err => reject(err))
		})
	},

	signToken: (email) => {
		return new Promise(async (resolve, reject) => {
			jwt.sign({user_email: email}, jwtSecret, {expiresIn: "3h"}, (err, token) => {
				if(err) reject(err)
				else resolve(token)
			})
		})
	},

	checkAuth: (req, res, next) => {
		let header = req.headers.authorization
		if(!header || header.split(" ")[0].toLowerCase() !== "bearer") return res.status(401).json({
			"status": "error",
			"message": "Missing or malformed Authorization header"
		})
		let token = header.split(" ")[1]
		jwt.verify(token, jwtSecret, (err, authData) => {
			if(err) return res.status(401).json({
				"status": "error",
				"message": "Invalid bearer token"
			})
			req.user_email = authData.user_email
			next()
		})
	}
}