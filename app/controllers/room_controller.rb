require 'net/http'
require 'json'

class RoomController < ApplicationController
  
  def play
    new_deck
    @deck_cards = []
  end

  def flop
    @deck_cards += draw_cards(3)
  end

  def river
    @deck_cards += draw_cards(1)
  end

  def turn
    @deck_cards += draw_cards(1)
  end

  protected
  def new_deck
    uri = URI('https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1')
    response = JSON.parse(Net::HTTP.get(uri))
    @deck_id = response['deck_id']
  end

  def draw_cards(number)
    uri = URI("https://deckofcardsapi.com/api/deck/#{@deck_id}/draw/?count=#{number}")
    response = JSON.parse(Net::HTTP.get(uri))
    @cards = response['cards']
  end
end
