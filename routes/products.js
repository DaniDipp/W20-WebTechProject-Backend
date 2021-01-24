const express = require('express')
const router = express.Router()
const db = require("./../db").getInstance();
	
router.route('/:id')
	.get(async function (req, res){
		if(!Number.isNaN(parseInt(req.params.id))){
			id = parseInt(req.params.id)

			try {
				const rows = await db.query("SELECT p.id, p.name, p.price, p.description, p.image, p.category_name, AVG(r.value) AS average_rating FROM products p LEFT JOIN ratings r ON p.id = r.product_id WHERE p.id = ? GROUP BY p.id", [id])
				if(rows[0]){
					return res.status(200).json({
						status: "success",
						message: "Got product from DB",
						product: {
							id: rows[0].id,
							name: rows[0].name,
							price: rows[0].price,
							description: rows[0].description,
							image: rows[0].image,
							category_name: rows[0].category_name,
							average_rating: rows[0].average_rating
						}
					})
				} else {
					return res.status(404).json({
						status: "error",
						message: "Product with id "+id+" not found"
					})
				}
			
			} catch(err){
				console.error(err)
				res.status(500).json({
					status: "error",
					message: "Database error"
				})
			}
		} else if (req.params.id.toLowerCase() == "search"){
			let params = {}
			params.name =        req.query.name        ? req.query.name.toLowerCase()                : ""
			params.price_min =   req.query.price_min   ? parseInt(req.query.price_min)               : 0
			params.price_max =   req.query.price_max   ? parseInt(req.query.price_max)               : 65535
			params.description = req.query.description ? req.query.description.toLowerCase()         : ""
			params.category =    req.query.category    ? req.query.category.toLowerCase().split(",") : [""]

			try {
				const rows = await db.query(
					`SELECT p.id, p.name, p.price, p.description, p.image, p.category_name, AVG(r.value) AS average_rating FROM products p LEFT JOIN ratings r ON p.id = r.product_id
					WHERE p.name LIKE ?
					AND p.price >= ?
					AND p.price <= ?
					AND p.description LIKE ?
					AND ( ${params.category.map(e => "p.category_name LIKE ?").join(" OR ")} )
					GROUP BY p.id`,
					[`%${params.name}%`, params.price_min, params.price_max, `%${params.description}%`, params.category.map(e => `%${e}%`)]
				)
				
				return res.status(200).json({
					status: "success",
					message: "Got products from DB",
					products: rows
				})
				
			
			} catch(err){
				console.error(err)
				res.status(500).json({
					status: "error",
					message: "Database error"
				})
			}
			
		} else {
			res.status(400).json({
				status: "error",
				message: "Invalid route. '"+req.params.id+"' must be an integer id or 'search'."
			})
		}
	})
	.patch(function (req, res){
		res.status(501).json({
			status: "unimplemented",
			message: "Update product"
		})
	})
	.delete(function (req, res){
		res.status(501).json({
			status: "unimplemented",
			message: "Delete product"
		})
	})

	
router.route('/')
	.get(async function (req, res){
		try {
			const rows = await db.query(`SELECT p.id, p.name, p.price, p.description, p.image, p.category_name, AVG(r.value) AS average_rating FROM products p LEFT JOIN ratings r ON p.id = r.product_id GROUP BY p.id`)
			
			return res.status(200).json({
				status: "success",
				message: "Got products from DB",
				products: rows
			})
		
		} catch(err){
			console.error(err)
			res.status(500).json({
				status: "error",
				message: "Database error"
			})
		}
	})
	.post(function (req, res){
		res.status(501).json({
			status: "unimplemented",
			message: "Add new product"
		})
	})

module.exports = router