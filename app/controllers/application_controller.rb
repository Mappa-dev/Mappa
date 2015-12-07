# encoding: utf-8
require 'riotgames_api.rb'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def hello 
    RiotGamesAPI.set_region('NA')
    render text: "hello" 
  end
  

end
