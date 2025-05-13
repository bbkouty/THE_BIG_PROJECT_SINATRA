require 'csv'

class Gossip 
    attr_reader :author, :content, :date_last_update

    def initialize (author, content)
        @content = content
        @author = author
        @date_last_update = Time.now.to_s
    end

    #saving the gossip in the database
    def save 
        file_path = "./db/gossip.csv"
        headers = ["author", "content", "date_last_update"]
    
        # Vérifie si le fichier existe et si les en-têtes sont absents ou incorrects
        file_exists = File.exist?(file_path)
        headers_missing = false
        if file_exists
            begin
                headers_missing = CSV.open(file_path, &:readline) != headers
            rescue CSV::MalformedCSVError
                headers_missing = true
            end
        end
    
        # Réécrit le fichier avec les en-têtes si nécessaire
        if !file_exists || headers_missing
            CSV.open(file_path, "w") do |csv|
                csv << headers
            end
        end
    
        # Ajoute les données
        CSV.open(file_path, "a") do |csv|
            csv << [self.author.to_s, self.content.to_s, @date_last_update]
        
        end
    end

    def self.all
        all_gossips = []
        
        CSV.foreach("./db/gossip.csv", headers: true) do |csv|
            all_gossips << csv.to_h
        end
        
        return all_gossips
    end

    def self.find(id)
        gossip = []
        count = 0

        CSV.foreach("./db/gossip.csv", headers: true) do |csv|
            if count == id.to_i then
                gossip << csv.to_h
            end
            count = count + 1
            #return gossip << csv.to_h if csv["id"] == id.to_s
        end
        return gossip
    end

end