

import json
from pymongo import MongoClient
import pandas as pd
from datetime import datetime

db_name= 'fleximart'
collection='products_catalog'
mongo_url="mongodb://localhost:27017"
with open(file='products_catalog.json',mode='r', encoding='utf-8') as f:
    data=json.load(f)

client= MongoClient(mongo_url)
db=client[db_name]
col=db[collection]

//  1: Load Data
col.delete_many({})
rec=col.insert_many(data)
print(f"inserted {len(rec.inserted_ids)} documents into {db_name}.{collection}")


//  2: Basic Query 
// Find all products in "Electronics" category with price < 50000

db.products.find(
  {
    category: "Electronics",price: { $lt: 50000 }
  },
  {
    name: 1,
    price: 1,
    stock: 1,
    _id: 0
  }
).pretty();


// 3: Review Analysis 
// Find all products that have average rating >= 4.0

db.products.aggregate([
  {$match: {"reviews.0": { $exists: true }}},
  {
    $addFields: {
      avgRating: {
        $avg: "$reviews.rating"
      }
    }
  },
  {
    $match: {
      avgRating: { $gte: 4.0 }
    }
  },
  {
    $project: {
      name: 1,
      category: 1,
      avgRating: 1,
      "reviews.rating": 1,
      _id: 0
    }
  }
]).pretty();



// 4: Update Operation 
// Add a new review to product "ELEC001"

db.products.updateOne(
  { product_id: "ELEC001" },
  {
    $push: {
      reviews: {
        user: "U999",
        rating: 4,
        comment: "Good value",
        date: new Date()           
      }
    }
  }
);



//  5: Complex Aggregation 
// Calculate average price by category,Return: category, avg_price, product_count,Sort by avg_price descending

db.products.aggregate([
  {
    $group: {
      _id: "$category",
      avg_price: { $avg: "$price" },
      product_count: { $sum: 1 }
    }
  },
  {
    $project: {
      category: "$_id",
      avg_price: 1,
      product_count: 1,
      _id: 0
    }
  },
  {$sort: {avg_price: -1}}
  ]).pretty();
