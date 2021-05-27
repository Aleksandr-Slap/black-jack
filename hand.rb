# frozen_string_literal: true

class Hand
  attr_reader :cards_player, :cards_dealer

  def initialize(player, dealer)
    @dealer = dealer
    @player = player
    @cards_player = []
    @cards_dealer = []
  end

  def add_card_player(card)
    @cards_player << card
  end

  def add_card_dealer(card)
    @cards_dealer << card
  end

  def player_cards
    @cards_player
  end

  def player_points
    points_player
  end

  def dealer_cards
    @cards_dealer
  end

  def dealer_points
    points_dealer
  end

  def clear_card
    @cards_player.clear
    @cards_dealer.clear
  end

  def points_player
    total = cards_player.inject(0) { |sum, card| sum + card.value }
    total -= 10 if total > 21 && cards_player.detect { |card| card.rank == 'A' }
    total
  end

  def points_dealer
    total = cards_dealer.inject(0) { |sum, card| sum + card.value }
    total -= 10 if total > 21 && cards_dealer.detect { |card| card.rank == 'A' }
    total
  end
end
