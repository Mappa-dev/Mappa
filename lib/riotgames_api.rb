# encoding: utf-8
module RiotGamesAPI 
  module_function

  @region = "global"
  @base_url = "https://#{@region}.api.pvp.net/api/lol/#{@region}"

  def set_api_key(key)
    @api_key = key unless key.nil?
  end 

  def set_region(reg)
    @region = reg.downcase unless reg.nil?
    update_base_url
  end

  def update_base_url
    @base_url = "https://#{@region}.api.pvp.net/api/lol/#{@region}"
  end

  def get_url
    @base_url
  end

  def send_query(api_name, api_params)
    # TODO: implement exception handling
    puts  "#{@base_url}/#{api_name}/#{api_params}api_key=#{@api_key}" 
    return HTTParty.get( "#{@base_url}/#{api_name}/#{api_params}api_key=#{@api_key}" )
  end

  def get_summoner_by_name(summoner_name)
    summoner_name = summoner_name.split(' ').join('')
    response = send_query( "v1.4/summoner/by-name", "#{summoner_name}?" )
    begin
      JSON.parse(response.body).fetch( "#{summoner_name}" )
    rescue KeyError
    end
  end

  def get_recent_game_ids(summoner_id)
    # TODO: process response codes for error handling
    g_ids = []
    response = send_query( "v1.3/game/by-summoner", "#{summoner_id}/recent?" )
    JSON.parse( response.body ).fetch( "games" ).each{ |game| g_ids << game["gameId"] }
    g_ids
  end

  def get_match_data(game_id, incl_tline, id)
    # TODO: process response codes for error handling
    # TODO: refactor! code is extremely ugly
    response = send_query( "v2.2/match", "#{game_id}?includeTimeline=#{incl_tline}&" )
    participantId = parse_participant_id(response, id)
    parse_kill_events(response, participantId)
  end

  def parse_participant_id(response, id)
    participantId = 0
    hashBody = JSON.parse( response.body )
    if hashBody.has_key?("participantIdentities")
      hashBody.fetch("participantIdentities").each { |playerset| participantId = playerset["participantId"] if playerset.has_key?("player") and playerset["player"]["summonerId"] == id }
    end
    participantId
  end


  def parse_kill_events(response, participantId)
    fevents = []
    kevents = []
    hashKill = JSON.parse( response.body ) 
    if hashKill.has_key?("timeline")
      hashKill.fetch( "timeline" ).fetch( "frames" ).each{ |frame| fevents << frame["events"] unless frame["events"].nil?}
    end
    fevents.each{ |event_set| event_set.each{ |mini_event| kevents << mini_event if mini_event.has_value?("CHAMPION_KILL") and mini_event["victimId"] == participantId } } 
    kevents
  end

end
