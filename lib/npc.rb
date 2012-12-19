module Npc
  def self.greedy(treasure)
    Greedy.new(treasure)
  end

  def self.generous(treasure)
    Generous.new(treasure)
  end

  def self.stingy
    DoNotTouch.new
  end

  def self.shopkeeper(takes, gives)
    Shopkeeper.new(takes, gives)
  end

  class DoNotTouch
    def interrogate(treasure)
      treasure
    end
  end

  class Greedy
    def initialize(treasure)
      @treasure = treasure
    end

    def interrogate(treasure)
      treasure - [@treasure]
    end
  end

  class Generous
    def initialize(treasure)
      @treasure = treasure
    end

    def interrogate(treasure)
      treasure + [@treasure]
    end
  end

  class Shopkeeper
    def initialize(take, give)
      @take = take
      @greediness = Greedy.new(take)
      @generosity = Generous.new(give)
    end

    def interrogate(treasure)
      if treasure.include?(@take)
        @generosity.interrogate(@greediness.interrogate(treasure))
      else
        treasure
      end
    end
  end
end
