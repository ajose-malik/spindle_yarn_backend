class Product
    if(ENV['DATABASE_URL'])
      uri = URI.parse(ENV['DATABASE_URL'])
      DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
else
  DB = PG.connect({:host => "localhost", :port => 5432, :dbname => 'spindle_yarn_backend_development'})
end
# INDEX
def self.all
    results = DB.exec("SELECT * FROM clothing")
    return results.map do |result|
 # (SELECT * FROM menwear WHERE category = 'men')
        {
            "id" => result["id"].to_i,
            "name" => result["name"],
            "image" => result["image"],
            "price" => result["price"],
            "description" => result["description"],
            "category" => result["category"]
        }
    end

end



# SHOW

def self.find(id)
    results = DB.exec("SELECT * FROM clothing WHERE id=#{id}")
    return {
        "id" => results.first["id"].to_i,
        "name" => results.first["name"],
        "image" => results.first["image"],
        "price" => results.first["price"],
        "description" => results.first["description"],
        "category" => results.first["category"]
    }

end

#create
def self.create(res)
    results = DB.exec(
    <<-SQL
        INSERT INTO clothing (name, image, price, description, category)
        VALUES  ('#{res["name"]}','#{res["image"]}','#{res["price"]} ','#{res["description"]}','#{res["category"]}')
        RETURNING id, name, image, price, description,category
    SQL
    )
    return {
        "id" => results.first["id"].to_i,
        "name" => results.first["name"],
        "image" => results.first["image"],
        "price" => results.first["price"],
        "description" => results.first["description"],
        "category" => results.first["category"]
    }

end
#DELETE

def self.delete(id)
results =DB.exec("DELETE FROM clothing WHERE id= #{id}")
return{"deleted" => true}

end

#update

def self.update(id,res)
results = DB.exec(
    <<-SQL
         UPDATE clothing
         SET name = '#{res["name"]}' , image ='#{res["image"]}',price ='#{res["price"]}',description ='#{res["description"]}',
         category ='#{res["category"]}'
         WHERE id=#{id}
         RETURNING id, name, image, price, description,category
    SQL
)

  end
end
