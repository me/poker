require 'debugger'

module Poker

  class Hand
    include Comparable

    FIGURES = {'T' => 10, 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14}
    RANKS = [
      :high_card, :pair, :two_pairs, :three_of_a_kind, :straight, 
      :flush, :full_house, :four_of_a_kind, :straight_flush
    ]

    attr_reader :cards

    def initialize(cards)
      unless cards.is_a?(Enumerable) && cards.length == 5
        raise ArgumentError.new "A pocker hand should be an array of 5 cards" 
      end
      @cards = cards
    end

    def values
      @values ||= cards.map{ |card| value(card) }.sort.reverse
    end

    def value(card)
      v = card[0].chr
      FIGURES[v] || v.to_i
    end

    def high_card
      values
    end

    def pair
      pairs = values.select{ |card| values.count(card) == 2 }
      return nil unless pairs.length == 2
      [pairs.first] + (values - pairs)
    end

    def two_pairs
      pairs = values.select{ |card| values.count(card) == 2 }
      return nil unless pairs.length == 4
      [pairs.first, pairs.last] + (values - pairs)
    end

    def three_of_a_kind
      triples = values.select{ |card| values.count(card) == 3 }
      return nil if triples.empty?
      [triples.first] + (values - triples)
    end

    def straight
      return nil unless is_straight?
      [values.first]
    end

    def flush
      return nil unless is_flush?
      values
    end

    def full_house
      pair = values.select{ |card| values.count(card) == 2 }
      triple = values.select{ |card| values.count(card) == 3 }
      return nil if pair.empty? || triple.empty?
      [triple.first, pair.first]
    end

    def four_of_a_kind
      four = values.select{ |card| values.count(card) == 4 }
      return nil unless four.length == 4
      [four.first] + (values - four)
    end

    def straight_flush
      return nil unless is_straight? && is_flush?
      [values.first]
    end

    def is_straight?
      values.reverse.each_cons(2).select{ |a, b| b != a + 1 }.empty?
    end

    def is_flush?
      cards.map{ |card| card[1].chr }.uniq.length == 1
    end

    def <=>(other)
      RANKS.reverse.each do |method|
        us = self.send(method) || []
        them = other.send(method) || []
        comparison = us <=> them
        return comparison if comparison != 0
      end
      return 0
    end

  end

end

