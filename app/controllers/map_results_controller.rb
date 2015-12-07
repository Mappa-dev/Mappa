class MapResultsController < ApplicationController
  def results
  	# add process to parse data here
  	# parse data through params['data']
	RiotGamesAPI.set_region(params['region'])
	RiotGamesAPI.set_api_key(ENV['RIOT_API_KEY'])
	vSum = RiotGamesAPI.get_summoner_by_name(params['summoner'])
    gameArray = RiotGamesAPI.get_recent_game_ids(vSum['id'])
    deathLoc = Array.new
    deathArr = Array.new
    gameArray.each{ |g|
    	puts "results here:" 
    	deathHash = RiotGamesAPI.get_match_data(g, "true", vSum['id'])
    	deathLoc << deathHash
    }
    deathLoc.each{ |hashSet|
    	hashSet.each { |hashGame|
    		puts hashGame.class 
    		puts hashGame["position"]
    		deathArr << hashGame["position"]
    	}
    }
    @deathLocations = deathArr
  end
end
