const express = require('express')
const router = express.Router()
const auth = require("./../auth")
const db = require("./../db").getInstance()

router.route('/login')
	.post(async function (req, res){
		let email = req.body.email
		let password = req.body.password

		if (!email || !password){
			missing = ["email", "password"].filter(e => !req.body[e])
			return res.status(400).json({
				"status": "error",
				"message": "Required user attributes missing",
				"missing_attributes": missing
			})
		}

		email = email.toLowerCase()

		try {
			const rows = await db.query(`SELECT email, password FROM users WHERE email = ?`, [email])
			if(!rows[0]) {
				err = new Error("User not found")
				err.code = 'INVALID'
				throw err
			}

			hashedPassword = rows[0].password
			if(!await auth.checkPassword(password, hashedPassword)){
				err = new Error("Wrong password")
				err.code = 'INVALID'
				throw err
			}

			const token = await auth.signToken(email)

			return res.status(200).json({
				status: "success",
				message: "Successfully logged in with email "+email,
				token: token
			})
		} catch(err){
			if(err.code == 'INVALID'){
				return res.status(404).json({
					status: "error",
					message: "Invalid email/password combination"
				})
			} else {
				console.error(err)
				return res.status(500).json({
					status: "error",
					message: "Database error"
				})
			}
			
		}
		

	})


router.route('/')
	.get(auth.checkAuth, async function (req, res){
		const email = req.user_email
		try {
			const rows = await db.query(`SELECT email, name, address, phone, creditcard FROM users WHERE email = ?`, [email])
			if(rows[0]){
				return res.status(200).json({
					status: "success",
					message: "Got user from DB",
					user: {
						email: rows[0].email,
						name: rows[0].name,
						address: rows[0].address,
						phone: rows[0].phone,
						creditcard: rows[0].creditcard
					}
				})
			} else {
				return res.status(404).json({
					status: "error",
					message: "User with email "+email+" not found"
				})
			}
		} catch(err){
			console.error(err)
			return res.status(500).json({
				status: "error",
				message: "Database error"
			})
			
		}
	})
	.post(async function (req, res){
		const name = req.body.name
		let email = req.body.email
		let password = req.body.password

		if (!name || !email || !password){
			missing = ["name", "email", "password"].filter(e => !req.body[e])
			return res.status(400).json({
				"status": "error",
				"message": "Required user attributes missing",
				"missing_attributes": missing
			})
		}

		email = email.toLowerCase()
		password = await auth.encryptPassword(password)
		const token = await auth.signToken(email)

		try {
			const rows = await db.query(`INSERT INTO users (email, password, name) VALUES (?, ?, ?)`, [email, password, name])
			if(rows.affectedRows !== 1){
				console.error(rows)
				throw new Error("Affected rows !== 1");
			}
			return res.status(200).json({
				status: "success",
				message: "Added new user to DB",
				user: {
					email: email,
					token: token,
					name: name
				}
			})
		
		} catch(err){
			if(err.code == 'ER_DUP_ENTRY'){
				return res.status(409).json({
					status: "error",
					message: "Email already registered"
				})
			} else {
				console.error(err)
				return res.status(500).json({
					status: "error",
					message: "Database error"
				})
			}
			
		}

	})
	.patch(auth.checkAuth, async function (req, res){
		const email = req.user_email
		let params = {}
		if(req.body.password) params.password = await auth.encryptPassword(req.body.password)
		if(req.body.name) params.name = req.body.name
		if(req.body.address) params.address = req.body.address
		if(req.body.phone) params.phone = req.body.phone
		if(req.body.creditcard) params.creditcard = req.body.creditcard

		if(JSON.stringify(params) == JSON.stringify({})) return res.status(400).json({
			"status": "error",
			"message": "no relevant body parameters found"
		})

		try {
			const rows = await db.query(`UPDATE users SET ${Object.keys(params).map(e => e+" = ?").join(", ")} WHERE email = ?`, [...Object.values(params), email])
			if(rows.affectedRows == 1){
				return res.status(200).json({
					status: "success",
					message: "Updated user with email "+email+" in DB"
				})
			} else {
				return res.status(404).json({
					status: "error",
					message: "User with email "+email+" not found"
				})
			}
		} catch(err){
			console.error(err)
			return res.status(500).json({
				status: "error",
				message: "Database error"
			})
			
		}
	})
	.delete(auth.checkAuth, async function (req, res){
		const email = req.user_email

		try {
			const rows = await db.query(`DELETE FROM users WHERE email = ?`, [email])
			console.log(rows)
			if(rows.affectedRows == 1){
				return res.status(200).json({
					status: "success",
					message: "Deleted user with email "+email+" from DB"
				})
			} else {
				return res.status(404).json({
					status: "error",
					message: "User with email "+email+" not found"
				})
			}
		} catch(err){
			console.error(err)
			return res.status(500).json({
				status: "error",
				message: "Database error"
			})
			
		}
	})




module.exports = router