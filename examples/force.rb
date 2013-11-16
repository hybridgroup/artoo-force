require 'artoo'

connection :force, :adaptor => :force, 
  :username => ENV["SF_USERNAME"],
  :password => ENV["SF_PASSWORD"],
  :security_token => ENV["SF_SECURITY_TOKEN"]
  :client_id => ENV["SF_CLIENT_ID"]
  :client_secret => ENV["SF_CLIENT_SECRET"]
  :instance_url => ENV["SF_INSTANCE_URL"]
device :force, :driver => :force, :connection => :capture

work do
  force.query = 'SELECT id, Name, Sphero_Name__c, Content__c FROM Sphero_Message__c ORDER BY Name DESC LIMIT 10'
  on force , :query_results => proc { |*value|
    puts value[1].inspect
  }
end
