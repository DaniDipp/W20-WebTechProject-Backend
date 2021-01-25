const express = require('express')
const { prependListener } = require('process')
const router = express.Router()
const auth = require("./../auth")
const db = require("./../db").getInstance()

router.route('/:product_id')
	.get(async function (req, res){
		const product_id = req.params.product_id ? parseInt(req.params.product_id) : undefined

		if (Number.isNaN(product_id)){
			return res.status(400).json({
				"status": "error",
				"message": "Invalid route parameter: product_id"
			})
		}

		try {
			const rows = await db.query(`
				SELECT * FROM (
					SELECT r.value, r.text, p.id, p.name, p.price, p.description, p.image, p.category_name, u.name as u_name
					FROM products p
					JOIN ratings r ON p.id = r.product_id
					JOIN users u ON r.user_email = u.email
					WHERE r.product_id = ?
				) a1
				LEFT JOIN (
					SELECT r.product_id, AVG(r.value) AS average_rating
					FROM ratings r GROUP BY r.product_id
				) a2 ON a1.id = a2.product_id`, [product_id])

			return res.status(200).json({
				status: "success",
				message: "Got ratings for product "+product_id,
				ratings: rows.map(e => {return {
					value: e.value,
					text: e.text,
					user: {name: e.u_name},
					product: {id: e.id, name: e.name, price: e.name, description: e.description, image: e.image, category: e.category_name, average_rating: e.average_rating}
				}})
			})
			
		} catch(err){
			console.error(err)
			return res.status(500).json({
				status: "error",
				message: "Database error"
			})
			
		}
	})
	.patch(auth.checkAuth, async function (req, res){
		const email = req.user_email
		const product_id = req.params.product_id ? parseInt(req.params.product_id) : undefined

		if (Number.isNaN(product_id)){
			return res.status(400).json({
				"status": "error",
				"message": "Invalid route parameter: product_id"
			})
		}
		
		let params = {}
		if(req.body.value) params.value = parseInt(req.body.value)
		if(req.body.text) params.text = req.body.text
		if(JSON.stringify(params) == JSON.stringify({})) return res.status(400).json({
			"status": "error",
			"message": "no relevant body parameters found"
		})

		try {
			const rows = await db.query(`UPDATE ratings SET ${Object.keys(params).map(e => e+" = ?").join(", ")} WHERE user_email = ? AND product_id = ?`, [...Object.values(params), email, product_id])
			if(rows.affectedRows == 1){
				return res.status(200).json({
					status: "success",
					message: "Updated rating for product "+product_id+" by user "+email+" in DB"
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
		const product_id = req.params.product_id ? parseInt(req.params.product_id) : undefined

		if (Number.isNaN(product_id)){
			return res.status(400).json({
				"status": "error",
				"message": "Invalid route parameter: id"
			})
		}

		try {
			const rows = await db.query(`DELETE FROM ratings WHERE user_email = ? AND product_id = ?`, [email, product_id])
			if(rows.affectedRows == 1){
				return res.status(200).json({
					status: "success",
					message: "Removed rating for product "+product_id+" by user "+email+" in DB"
				})
			} else {
				return res.status(404).json({
					status: "error",
					message: "User with email "+email+" does not have a rating for product "+product_id
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
		try {
			const rows = await db.query(`
			SELECT * FROM (
				SELECT r.value, r.text, p.id, p.name, p.price, p.description, p.image, p.category_name, u.name as u_name
				FROM products p
				JOIN ratings r ON p.id = r.product_id
				JOIN users u ON r.user_email = u.email
				WHERE u.email = ?
			) a1
			LEFT JOIN (
				SELECT r.product_id, AVG(r.value) AS average_rating
				FROM ratings r GROUP BY r.product_id
			) a2 ON a1.id = a2.product_id`, [req.user_email])

			return res.status(200).json({
				status: "success",
				message: "Got ratings for user "+req.user_email,
				ratings: rows.map(e => {return {value: e.value, text: e.text, product: {id: e.id, name: e.name, price: e.name, description: e.description, image: e.image, category: e.category_name, average_rating: e.average_rating}}})
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
		const product_id = req.body.product_id ? parseInt(req.body.product_id) : undefined
		const user_email = req.user_email
		const value = req.body.value ? parseInt(req.body.value) : undefined
		const text = req.body.text || null

		if (!product_id || !value){
			missing = ["product_id", "value"].filter(e => !req.body[e])
			return res.status(400).json({
				"status": "error",
				"message": "Required user attributes missing or invalid",
				"missing_attributes": missing
			})
		}

		try {
			const rows = await db.query(`INSERT INTO ratings (product_id, user_email, value, text) VALUES (?, ?, ?, ?)`, [product_id, user_email, value, text])
			if(rows.affectedRows !== 1){
				console.error(rows)
				throw new Error("Affected rows !== 1");
			}
			return res.status(200).json({
				status: "success",
				message: "Added new rating to DB",
				rating: {
					product_id: product_id,
					user_email: user_email,
					value: value,
					text: text
				}
			})
		
		} catch(err){
			if(err.code == 'ER_DUP_ENTRY'){
				return res.status(409).json({
					status: "error",
					message: "user "+user_email+"already posted a rating for this product "+product_id+". Use PATCH to edit it"
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





module.exports = router