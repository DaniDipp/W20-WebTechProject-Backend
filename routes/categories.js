const express = require('express')
const { type } = require('os')
const router = express.Router()
const db = require("./../db").getInstance()
	
router.route('/')
	.get(async function (req, res){
		try {
			const rows = await db.query(`SELECT c.name, COUNT(p.name LIKE "%") AS items FROM categories c LEFT JOIN products p ON c.name=p.category_name GROUP BY c.name`)
		
			return res.status(200).json({
				status: "success",
				message: "Got categories from DB",
				categories: rows
			})
			
		} catch(err){
			console.error(err)
			return res.status(500).json({
				status: "error",
				message: "Database error"
			})
			
		}
	})
	.post(function (req, res){
		res.status(501).json({
			status: "unimplemented",
			message: "Add new category"
		})
	})
	.patch(function (req, res){
		res.status(501).json({
			status: "unimplemented",
			message: "Rename category"
		})
	})
	.delete(function (req, res){
		res.status(501).json({
			status: "unimplemented",
			message: "Delete category"
		})
	})

module.exports = router