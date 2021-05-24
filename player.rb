# frozen_string_literal: true

class Player
  attr_reader :name, :cards, :bank

  def initialize(name, bank = 100)
    @name = name
    @cards = []
    @bank = bank
  end

  def add_card(card)
    cards << card
  end

  def clear_cards
    cards.clear
  end

  def increase_bank(amount)
    @bank += amount
  end

  def reduce_bank(amount)
    @bank -= amount if amount <= bank
  end

  def points
    total = cards.inject(0) { |sum, card| sum + card.value }
    total -= 10 if total > 21 && cards.detect { |card| card.rank == 'A' }
    total
  end
end
