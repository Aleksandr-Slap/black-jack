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
  puts 'Enter player action'
  puts '1. Skip'
  puts '2. Add card'
  puts 'Any other char to open cards'
  action = gets.chomp.to_i
  if action == 1
    :skip
  elsif action == 2
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