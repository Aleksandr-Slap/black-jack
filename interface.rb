# frozen_string_literal: true

require_relative 'card_deck'
require_relative 'player'
require_relative 'game'
require_relative 'interface'
require_relative 'card'
require_relative 'hand'

class Interface
  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def start
    dealer = Player.new('Dealer')
    player_name = enter_player_name
    player = Player.new(player_name)
    hand = Hand.new(player, dealer)

    loop do
      game = Game.new(player, dealer, hand)
      show_bet(game)
      game.take_bets
      show_banks(game)
      game.deal_cards_first_time
      show_dealer_cards_before
      show_player_cards(game)
      show_player_points(game)
      game.player_action(enter_player_action)
      show_cards(game)
      show_points(game)
      show_result(game)
      game.pay_bank
      show_banks(game)
      answer = play_again?
      game.restart_game(answer)
      break if answer == :n || game.game_over?
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

  def enter_player_name
    puts "Enter player's name:"
    gets.chomp
  end

  def show_bet(game)
    puts "Game's bet: #{game.bet}"
  end

  def show_dealer_cards_before
    puts "Dealer cards:\n**\n**"
  end

  def show_banks(game)
    puts "Dealer bank: #{game.dealer_bank}"
    puts "#{game.player_name} bank: #{game.player_bank}"
  end

  def show_player_cards(game)
    puts "#{game.player_name} cards:"
    game.player_cards.each { |card| puts card }
  end

  def show_cards(game)
    puts 'Dealer cards:'
    game.dealer_cards.each { |card| puts card }
    show_player_cards(game)
  end

  def show_player_points(game)
    puts "#{game.player_name} points: #{game.player_points}"
  end

  def show_points(game)
    puts "Dealer points: #{game.dealer_points}"
    show_player_points(game)
  end

  def enter_player_action
    puts '1. Skip'
    puts '2. Add card'
    puts 'Any other char to open cards'
    action = gets.chomp.to_i
    case action
    when 1
      :skip
    when 2
      :add_card
    end
  end

  def show_result(game)
    puts game.result.to_s.split('_').join(' ').capitalize
  end

  def play_again?
    puts 'Play again? y/n'
    gets.chomp.downcase.to_sym
  end
end

Interface.new.start
