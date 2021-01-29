class Product
    DB =PG.connect({:host => 'localhost', :port => 5432, :dbname => 'products_development'})


# INDEX


    def self.all
        results = DB.exec("SELECT * FROM products")
        return results.map do |result|
            {
                "id" => result["id"].to_i,
                "name" => result["name"],
                "image" => result["image"],
                "price" => result["price"].to_i,
                "qty" => result["qty"].to_i
            }
        end

    end

# SHOW

    def self.find(id)
        results = DB.exec("SELECT * FROM products WHERE id=#{id}")
        return {
            "id" => results.first["id"].to_i,
            "name" => results.first["name"],
            "image" => results.first["image"],
            "price" => results.first["price"].to_i,
            "qty" => results.first["qty"].to_i
        }

   end

#UPDATE
   def self.create(res)
    results =DB.exec(
        <<-SQL
           INSERT INTO products (name, image, price, qty)
           VALUES ('#{res["name"]}','#{res["image"]}','#{res["price"]}',#{res["qty"]})
           RETURNING id, name, image, price, qty
        SQL
    )
     return{
        "id" => results.first["id"].to_i,
        "name" => results.first["name"],
        "image" => results.first["image"],
        "price" => results.first["price"].to_i,
        "qty" => results.first["qty"].to_i
     }
end

#DELETE

def self.delete(id)
    results =DB.exec("DELETE FROM products WHERE id= #{id}")
    return{"deleted" => true}

end

#update

def self.update(id,res)
    results = DB.exec(
        <<-SQL
             UPDATE products
             SET name = '#{res["name"]}' , image ='#{res["image"]}',price ='#{res["price"]}',qty =#{res["qty"]}
             WHERE id=#{id}
             RETURNING id, name, image, price, qty
        SQL
    )

end


end
