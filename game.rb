# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
class Game
  BET = 10
  NUM_OF_PLAYERS = 2
  LIMIT_POINTS = 21
  DEALER_LIMIT = 17
  BANK = 100

  attr_reader :player, :dealer, :card_deck, :game_bank, :hand

  def initialize(player, dealer, hand)
    @hand = hand
    @dealer = dealer
    @player = player
    @card_deck = CardDeck.new
    @game_over = false
  end

  def player_name
    player.name
  end

  def take_bets
    dealer.reduce_bank(BET)
    player.reduce_bank(BET)
    self.game_bank = NUM_OF_PLAYERS * BET
  end

  def deal_cards_first_time
    2.times { give_card_to_player }
    2.times { give_card_to_dealer }
  end

  def player_action(action)
    case action
    when :add_card
      give_card_to_player
      dealer_move
    when :skip
      dealer_move
    end
  end

  # rubocop:disable Style/GuardClause
  def player_action_two(action)
    if action == :add_card
      give_card_to_player
      # when :skip
      #   dealer_move
    end
  end
  # rubocop:enable Style/GuardClause

  def player_cards
    hand.cards_player
  end

  def player_points
    hand.points_player
  end

  def player_bank
    player.bank
  end

  def dealer_cards
    hand.dealer_cards
  end

  def dealer_points
    hand.dealer_points
  end

  # rubocop:disable Style/IdenticalConditionalBranches
  def dealer_move
    if hand.points_dealer < DEALER_LIMIT
      give_card_to_dealer
      player_action_two(enter_player_action_next)
    else
      player_action_two(enter_player_action_next)
    end
  end

  def enter_player_action_next
    puts 'The dealer made a move. Your turn.'
    puts '1. Add card'
    puts '2. Open cards'
    action = gets.chomp.to_i
    :add_card if action == 1
  end

  # rubocop:enable Style/IdenticalConditionalBranches

  def dealer_bank
    dealer.bank
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/AbcSize
  def result
    if (hand.player_points <= LIMIT_POINTS && hand.player_points > hand.points_dealer) ||
       (hand.player_points <= LIMIT_POINTS && hand.points_dealer > LIMIT_POINTS)
      :player_win
    elsif (hand.points_dealer <= LIMIT_POINTS && hand.points_dealer > hand.player_points) ||
          (hand.points_dealer <= LIMIT_POINTS && hand.player_points > LIMIT_POINTS)
      puts 'Dealer win.'
      :dealer_win
    else
      :draw
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/AbcSize

  def pay_bank
    case result
    when :player_win
      player.increase_bank(game_bank)
    when :dealer_win
      dealer.increase_bank(game_bank)
    else
      return_bank
    end
  end

  def bet
    BET
  end

  def restart_game(decision)
    clear_cards if decision == :y
  end

  def game_over?
    player_bank < BET || dealer_bank < BET
  end

  private

  attr_writer :game_bank, :card_deck

  def give_card_to_player
    hand.add_card_player(card_deck.draw_card) if hand.cards_player.size < 3
  end

  def give_card_to_dealer
    hand.add_card_dealer(card_deck.draw_card) if hand.cards_dealer.size < 3
  end

  def return_bank
    player.increase_bank(BET)
    dealer.increase_bank(BET)
  end

  def clear_cards
    hand.clear_card
  end
end
# dealer = Player.new('Dealer')
# player = Player.new('Sasha')
# hand = Hand.new(dealer, player)
# game = Game.new(player, dealer,hand)
# dec = CardDeck.new

# p game.deal_cards_first_time
# p hand.cards_player
# p hand.cards_dealer

# rubocop:enable Metrics/ClassLength
