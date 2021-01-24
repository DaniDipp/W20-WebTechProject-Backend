const express = require('express')
const router = express.Router()
const auth = require("./../auth")
const db = require("./../db").getInstance()

router.route('/:id')
	.delete(auth.checkAuth, async function (req, res){
		const email = req.user_email
		const id = req.params.id ? parseInt(req.params.id) : undefined

		if (Number.isNaN(id)){
			return res.status(400).json({
				"status": "error",
				"message": "Invalid route parameter: id"
			})
		}

		try {
			const rows = await db.query(`DELETE FROM orders WHERE user_email = ? AND id = ?`, [email, id])
			console.log(rows)
			if(rows.affectedRows == 1){
				return res.status(200).json({
					status: "success",
					message: "Deleted order "+id+" from DB"
				})
			} else {
				return res.status(404).json({
					status: "error",
					message: "User with email "+email+" does not have access to order "+id
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

router.route('/')
	.get(auth.checkAuth, async function (req, res){
		const email = req.user_email
		try {
			const rows = await db.query(`SELECT o.id, o.time, o.status, p.name, p.price, p.description, p.image, p.category_name, AVG(r.value) AS average_rating FROM products p JOIN orders o ON p.id = o.product_id JOIN ratings r ON p.id = r.product_id WHERE o.user_email = ? GROUP BY r.product_id`, [email])

			return res.status(200).json({
				status: "success",
				message: "Got orders for user "+email,
				orders: rows.map(e => {return {id: e.id, time: e.time, status: e.status, product: {name: e.name, price: e.price, description: e.description, image: e.image, category: e.category_name, average_rating: e.average_rating}}})
			})
			
		} catch(err){
			console.error(err)
			return res.status(500).json({
				status: "error",
				message: "Database error"
			})
			
		}
	})
	.post(auth.checkAuth, async function (req, res){
		const time = req.body.time ? new Date(req.body.time) : undefined
		const status = req.body.status
		const user_email = req.user_email
		const product_id = req.body.product_id ? parseInt(req.body.product_id) : undefined

		if (!time || !status || !product_id){
			missing = ["time", "status", "product_id"].filter(e => !req.body[e])
			return res.status(400).json({
				"status": "error",
				"message": "Required user attributes missing or invalid",
				"missing_attributes": missing
			})
		}

		try {
			const rows = await db.query(`INSERT INTO orders (time, status, user_email, product_id) VALUES (?, ?, ?, ?) RETURNING id`, [time, status, user_email, product_id])
			if(!rows[0].id){
				console.error(rows)
				throw new Error("Affected rows !== 1");
			}
			return res.status(200).json({
				status: "success",
				message: "Added new user to DB",
				order: {
					id: rows[0].id,
					time: time,
					status: status,
					product_id: product_id
				}
			})
		
		} catch(err){
			console.error(err)
			return res.status(500).json({
				status: "error",
				message: "Database error"
			})
		
		}

	})



module.exports = router