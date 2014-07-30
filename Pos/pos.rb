require 'net/http'
require 'json'

def checkout
	
  loop do
      sleep(2)  
      uri = URI.parse('http://mighty-thicket-9709.herokuapp.com/bills/need_checkout')
      http = Net::HTTP.start(uri.host, uri.port) do |http|
        request = Net::HTTP::Get.new(uri.path)
        response = http.request request
       # puts JSON.parse(response.body)['id'] # print id 

        puts JSON.parse(response.body)[JSON.parse(response.body).length-1]
        


        if JSON.parse(response.body).any?
            id = JSON.parse(response.body)[JSON.parse(response.body).length-1]
            puts "Do you want to make a checkout?  Y/N: "
   		    x = gets.chomp.capitalize  
            if x == 'Y'
              uri2 = URI.parse('http://mighty-thicket-9709.herokuapp.com//bills/'+"#{id}"+'/change_status')
              http2 = Net::HTTP.start(uri.host, uri.port) do |http2|
                request2 = Net::HTTP::Get.new(uri2.path)
                response2 = http2.request request2
              end
              puts 'checkout succesfully'
		    else 
     	      puts 'Aborted'
    	    end         
          else 
            puts "Waiting for bills..."
          end
      end
    end
end
checkout