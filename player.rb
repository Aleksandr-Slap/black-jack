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
    @bank -= amount if amount <= self.bank
  end

  def points
    total = cards.inject(0) { |sum, card| sum + card.value }
    total -= 10 if total > 21 && cards.detect { |card| card.rank == 'A' }
    total
  end
end 





# class Card
#   attr_reader :suite, :rank, :value
#   def initialize(suite, rank)
#     @suite = suite
#     @rank = rank
#     @value = count_value
#   end

#   def to_s
#     "#{rank}#{suite}"
#   end

#   private

#   def count_value
#     case rank
#     when '2', '3', '4', '5', '6', '7', '8', '9', '10'
#       rank.to_i
#     when 'J', 'Q', 'K'
#       10
#     when 'A'
#       11
#     end
#   end
# end 

# player = Player.new('Sasha')
# # dealer = Player.new('Dealler')
# card = Card.new('+', 'K')
# card1 = Card.new('<>', 'Q')
# card2 = Card.new('^', '9')
# card3 = Card.new('^', '6')

# player.add_card(card2)
# player.add_card(card3)
# # dealer.add_card(card2)
# # dealer.add_card(card3)
# p player.points
# # p dealer.points