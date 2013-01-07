module Npc
  def self.greedy(treasure, matcher_hash = {})
    Greedy.new(treasure, matcher_hash)
  end

  def self.generous(treasure, matcher_hash = {})
    Generous.new(treasure, matcher_hash)
  end

  def self.stingy
    DoNotTouch.new
  end

  def self.shopkeeper(takes, gives, matcher_hash = {})
    Shopkeeper.new(takes, gives, matcher_hash)
  end

  class DoNotTouch
    def interrogate(treasure, character)
      treasure
    end
  end

  class Greedy
    def initialize(treasure, matcher_hash = {})
      @treasure = treasure
      @matchers = matcher_hash
    end

    def action_with(treasure)
      treasure - [@treasure]
    end

    def interrogate(treasure, character)
      when_clause = @matchers[:when]
      if when_clause
        if when_clause.call(character)
          action_with treasure
        else
          treasure
        end
      else
        action_with treasure
      end
    end
  end

  class Generous
    def initialize(treasure, matcher_hash = {})
      @treasure = treasure
      @matchers = matcher_hash
    end

    def action_with(treasure)
      treasure + [@treasure]
    end

    def interrogate(treasure, character)
      when_clause = @matchers[:when]
      if when_clause
        if when_clause.call(character)
          action_with treasure
        else
          treasure
        end
      else
        action_with treasure
      end
    end
  end

  class Shopkeeper
    def initialize(take, give, matcher_hash = {})
      @take = take
      @greediness = Greedy.new(take, matcher_hash)
      @generosity = Generous.new(give, matcher_hash)
    end

    def interrogate(treasure, character)
      if treasure.include?(@take)
        @generosity.interrogate(@greediness.interrogate(treasure, character), character)
      else
        treasure
      end
    end
  end
end
