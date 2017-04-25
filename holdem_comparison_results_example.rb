
#example of result from comparing cards using holdem gem

<PokerHand:0x007fedf01154f0
  @cards=
    [#<Card:0x007fedf0115338 @rank="9", @suit="h", @icon="♥">,
    #<Card:0x007fedf0115270 @rank="4", @suit="c", @icon="♣">,
    #<Card:0x007fedf01151a8 @rank="K", @suit="d", @icon="♦">,
    #<Card:0x007fedf01150e0 @rank="Q", @suit="d", @icon="♦">,
    #<Card:0x007fedf0115018 @rank="J", @suit="h", @icon="♥">],

  @poker_rank=#<PokerRank:0x007fedf0114f50
    @cards=
      [#<Card:0x007fedf0115338 @rank="9", @suit="h", @icon="♥">,
      #<Card:0x007fedf0115270 @rank="4", @suit="c", @icon="♣">,
      #<Card:0x007fedf01151a8 @rank="K", @suit="d", @icon="♦">,
      #<Card:0x007fedf01150e0 @rank="Q", @suit="d", @icon="♦">,
      #<Card:0x007fedf0115018 @rank="J", @suit="h", @icon="♥">],

    @sorted_cards=
      [#<Card:0x007fedf01151a8 @rank="K", @suit="d", @icon="♦">,
      #<Card:0x007fedf01150e0 @rank="Q", @suit="d", @icon="♦">,
      #<Card:0x007fedf0115018 @rank="J", @suit="h", @icon="♥">,
      #<Card:0x007fedf0115338 @rank="9", @suit="h", @icon="♥">,
      #<Card:0x007fedf0115270 @rank="4", @suit="c", @icon="♣">],

    @sorted_values=[13, 12, 11, 9, 4],

    @pairs=
      [[1, [#<Card:0x007fedf01151a8@rank="K", @suit="d", @icon="♦">]],
      [1, [#<Card:0x007fedf01150e0 @rank="Q", @suit="d", @icon="♦">]],
      [1, [#<Card:0x007fedf0115018 @rank="J", @suit="h", @icon="♥">]],
      [1, [#<Card:0x007fedf0115338 @rank="9", @suit="h", @icon="♥">]],
      [1, [#<Card:0x007fedf0115270 @rank="4", @suit="c", @icon="♣">]]],

    @suits=[["h", 2], ["d", 2], ["c", 1]],
    @score=[0, 13, 12, 11, 9, 4],
    @rank="K high"
  >
>

#call .cards
#call .poker_rank.cards
#call .poker_rank.score
#call .poker_rank.rank

#couldnt call .poker_rank.sorted_cards
#couldnt call .poker_rank.sorted_values
#couldnt call .poker_rank.pairs
#couldnt call .poker_rank.suits
