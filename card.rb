class Card
  attr_reader :suite, :rank, :value
  def initialize(suite, rank)
    @suite = suite
    @rank = rank
    @value = count_value
  end

  def to_s
    "#{rank}#{suite}"
  end

  private

  def count_value
    case rank
    when '2', '3', '4', '5', '6', '7', '8', '9', '10'
      rank.to_i
    when 'J', 'Q', 'K'
      10
    when 'A'
      11
    end
  end
end
