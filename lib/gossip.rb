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

    # Méthode pour mettre à jour un potin existant
    def self.update(id, author, content)
        # Lire tous les potins
        gossips = []
        CSV.foreach("./db/gossip.csv", headers: true) do |csv|
            gossips << csv.to_h
        end
        
        # Mettre à jour le potin spécifique
        gossips[id.to_i]["author"] = author
        gossips[id.to_i]["content"] = content
        gossips[id.to_i]["date_last_update"] = Time.now.to_s
        
        # Réécrire le fichier CSV avec les données mises à jour
        CSV.open("./db/gossip.csv", "w") do |csv|
            # Écrire les en-têtes
            csv << ["author", "content", "date_last_update"]
            
            # Écrire toutes les lignes
            gossips.each do |gossip|
                csv << [gossip["author"], gossip["content"], gossip["date_last_update"]]
            end
        end
    end

end