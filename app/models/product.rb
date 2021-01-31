class Product
    if ENV["DATABASE_URL"]
  PG.connect(ENV['DATABASE_URL'])
elsif
  DB = PG.connect({:host => "localhost", :port => 5432, :dbname => 'contacts_development'})
end
# INDEX


    def self.all
        results = DB.exec("SELECT * FROM menwear ORDER BY id ASC")
        return results.map do |result|

            {
                "id" => result["id"].to_i,
                "name" => result["name"],
                "image" => result["image"],
                "price" => result["price"],
                "description" => result["description"]
            }
        end

    end

        # def self.all
        #     results = DB.exec("SELECT * FROM womenwear ORDER BY id ASC")
        #     return results.map do |result|

        #         {
        #             "id" => result["id"].to_i,
        #             "name" => result["name"],
        #             "image" => result["image"],
        #             "price" => result["price"],
        #             "description" => result["description"]
        #         }
        #     end

        # end


# SHOW

    def self.find(id)
        results = DB.exec("SELECT * FROM menwear WHERE id=#{id}")
        return {
            "id" => results.first["id"].to_i,
            "name" => results.first["name"],
            "image" => results.first["image"],
            "price" => results.first["price"],
            "description" => results.first["description"]
        }

   end

#UPDATE
   def self.create(res)
    results =DB.exec(
        <<-SQL
           INSERT INTO menwear (name, image, price, description)
           VALUES ('#{res["name"]}','#{res["image"]}','#{res["price"]}',#{res["description"]})
           RETURNING id, name, image, price, description
        SQL
    )
     return{
        "id" => results.first["id"].to_i,
        "name" => results.first["name"],
        "image" => results.first["image"],
        "price" => results.first["price"],
        "description" => results.first["description"]
     }
end

#DELETE

def self.delete(id)
    results =DB.exec("DELETE FROM menwear WHERE id= #{id}")
    return{"deleted" => true}

end

#update

def self.update(id,res)
    results = DB.exec(
        <<-SQL
             UPDATE menwear
             SET name = '#{res["name"]}' , image ='#{res["image"]}',price ='#{res["price"]}',description =#{res["description"]}
             WHERE id=#{id}
             RETURNING id, name, image, price, description
        SQL
    )

end


end
