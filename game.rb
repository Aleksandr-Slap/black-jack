# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
class Game
  BET = 10
  NUM_OF_PLAYERS = 2
  LIMIT_POINTS = 21
  DEALER_LIMIT = 17
  BANK = 100

  attr_reader :player, :dealer, :card_deck, :game_bank

  def initialize(player, dealer)
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
    2.times { give_card_to(player) }
    2.times { give_card_to(dealer) }
  end

  def player_action(action)
    case action
    when :add_card
      give_card_to(player)
      dealer_move
    when :skip
      dealer_move
    end
  end

  def player_action_two(action)
    case action
    when :add_card
      give_card_to(player)
    when :skip
      dealer_move
    end
  end

  def player_cards
    player.cards
  end

  def player_points
    player.points
  end

  def player_bank
    player.bank
  end

  def dealer_cards
    dealer.cards
  end

  def dealer_points
    dealer.points
  end

  # rubocop:disable Style/IdenticalConditionalBranches
  def dealer_move
    if dealer.points < DEALER_LIMIT
      give_card_to(dealer)
      player_action_two(enter_player_action_next)
    else
      player_action_two(enter_player_action_next)
    end
  end

  # rubocop:enable Style/IdenticalConditionalBranches

  def dealer_bank
    dealer.bank
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/AbcSize
  def result
    if (player_points <= LIMIT_POINTS && player_points > dealer_points) ||
       (player_points <= LIMIT_POINTS && dealer_points > LIMIT_POINTS)
      :player_win
    elsif (dealer_points <= LIMIT_POINTS && dealer_points > player_points) ||
          (dealer_points <= LIMIT_POINTS && player_points > LIMIT_POINTS)
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

  def give_card_to(player)
    player.add_card(card_deck.draw_card) if player.cards.size < 3
  end

  def return_bank
    player.increase_bank(BET)
    dealer.increase_bank(BET)
  end

  def clear_cards
    player.clear_cards
    dealer.clear_cards
  end
end

# rubocop:enable Metrics/ClassLength
