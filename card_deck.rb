# frozen_string_literal: true

require_relative 'card'

class CardDeck
  attr_reader :deck

  def initialize
    @deck = build_card_deck
  end

  def draw_card
    deck.pop unless deck.empty?
  end

  private

  def build_card_deck
    temp_deck = []
    Card::SUITE.each do |suite|
      Card::RANK.each do |rank|
        card = Card.new(suite, rank)
        temp_deck << card
      end
    end
    temp_deck.shuffle!
  end
end
