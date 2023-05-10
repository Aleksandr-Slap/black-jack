# frozen_string_literal: true

class Player
  attr_reader :name, :cards, :bank

  def initialize(name, bank = 100)
    @name = name
    @bank = bank
  end

  def increase_bank(amount)
    @bank += amount
  end

  def reduce_bank(amount)
    @bank -= amount if amount <= bank
  end
end
