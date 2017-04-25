require 'net/http'
require 'json'
require 'holdem'

class RoomController < ApplicationController

  def home
    new_deck
    #@games = Room.all
    @filterrific = initialize_filterrific( Room, params[:filterrific],
      select_options: {
        with_type: Room.options_for_with_type,
        nop: Room.options_for_nop,
        ratings: Room.options_for_ratings
      },
      persistence_id: 'shared_key',
      default_filter_params: {},
      available_filters: [],
    ) or return
    @games = @filterrific.find

    respond_to do |format|
      format.html
      format.js
    end
  end

  def reset_filterrific
    # Clear session persistence
    session[:filterrific_restaurants] = nil
    # Redirect back to the index action for default filter settings.
    redirect_to home_path
  end

  def start
    @table_cards = []
    @player_cards = draw_cards(2)
    @player_cards.each_with_index{ |value, index|
      $redis.hset('player', index, value.to_json)
    }
  end

  def flop
    @table_cards = draw_cards(3)
    @table_cards.each_with_index{ |value, index|
      $redis.hset('deck', index, value.to_json)
    }
    @player_cards = player_cards
  end

  def turn
    flop = draw_cards(1)
    $redis.hset('deck', 3, flop[0].to_json)
    @table_cards = table_cards(4)
    @player_cards = player_cards
  end

  def river
    river = draw_cards(1)
    $redis.hset('deck', 4, river[0].to_json)
    @table_cards = table_cards(5)
    @player_cards = player_cards
  end

  def check
    p0 = cdcg(player_cards[0])
    p1 = cdcg(player_cards[1])
    t0 = cdcg(table_cards(5)[0])
    t1 = cdcg(table_cards(5)[1])
    t2 = cdcg(table_cards(5)[2])
    t3 = cdcg(table_cards(5)[3])
    t4 = cdcg(table_cards(5)[4])
    #compare different possibilities of player cards with table cards
    c1 = pnj([p0, p1, t0, t1, t2])
    c2 = pnj([p0, p1, t1, t2, t3])
    c3 = pnj([p0, p1, t2, t3, t4])
    c4 = pnj([p0, p1, t0, t1, t3])
    c5 = pnj([p0, p1, t0, t1, t4])
    c6 = pnj([p0, p1, t1, t2, t4])
    c7 = pnj([p0, p1, t0, t2, t3])
    c8 = pnj([p0, p1, t0, t3, t4])
    c9 = pnj([p0, p1, t1, t3, t4])
    c10 = pnj([p0, p1, t0, t2, t4])
    @compared = [c1, c2, c3, c4, c5, c6, c7, c8, c9, c10].max
    @cards_values = []
    @compared.cards.each do |c|
      if c.rank == 'T'
        @cards_values << [c.rank.gsub('T', '0'), c.suit.capitalize].join
      else
        @cards_values << [c.rank, c.suit.capitalize].join
      end
    end
    @best_cards = []
    @cards_values.each do |c|
      @best_cards << "https://deckofcardsapi.com/static/img/#{c}.png"
    end
    @best_cards
  end

  protected
  def new_deck
    uri = URI('https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1')
    response = JSON.parse(Net::HTTP.get(uri))
    $redis.set('deck_id', response['deck_id'])
  end

  def draw_cards(number)
    deck_id = $redis.get('deck_id')
    uri = URI("https://deckofcardsapi.com/api/deck/#{deck_id}/draw/?count=#{number}")
    response = JSON.parse(Net::HTTP.get(uri))
    return response['cards']
  end

  def player_cards
    return [JSON.parse($redis.hget('player', 0)), JSON.parse($redis.hget('player', 1))]
  end

  def table_cards(x)
    n = 0
    table_cards = []
    while n < x do
      table_cards << JSON.parse($redis.hget('deck', n))
      n+=1
    end
    table_cards
  end

  def cdcg(input)
    input['code'].downcase.capitalize.gsub '0', 'T'
  end

  def pnj(input)
    PokerHand.new(input.join(" "))
  end

end
