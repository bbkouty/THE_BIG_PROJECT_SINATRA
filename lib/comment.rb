require 'csv'

class Comment
  attr_reader :content, :gossip_id, :date_created

  def initialize(content, gossip_id)
    @content = content
    @gossip_id = gossip_id
    @date_created = Time.now.to_s
  end

  # Save a comment to the CSV file
  def save
    file_path = "./db/comments.csv"
    headers = ["content", "gossip_id", "date_created"]
    
    # Check if file exists and if headers are missing or incorrect
    file_exists = File.exist?(file_path)
    headers_missing = false
    if file_exists
      begin
        headers_missing = CSV.open(file_path, &:readline) != headers
      rescue CSV::MalformedCSVError
        headers_missing = true
      end
    end
    
    # Rewrite the file with headers if necessary
    if !file_exists || headers_missing
      CSV.open(file_path, "w") do |csv|
        csv << headers
      end
    end
    
    # Add the data
    CSV.open(file_path, "a") do |csv|
      csv << [self.content.to_s, self.gossip_id.to_s, @date_created]
    end
  end

  # Get all comments for a specific gossip
  def self.find_by_gossip_id(gossip_id)
    comments = []
    
    # Make sure the file exists before trying to read it
    file_path = "./db/comments.csv"
    return comments unless File.exist?(file_path)
    
    CSV.foreach(file_path, headers: true) do |csv|
      if csv["gossip_id"] == gossip_id.to_s
        comments << csv.to_h
      end
    end
    
    return comments
  end
end