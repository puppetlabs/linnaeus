require 'minitest/autorun'
require 'minitest/spec'

require 'treasure'
require 'npc'
require 'instruction'

describe Npc do
  let(:platinum) { Treasure.new("platinum!") }
  let(:gold) { Treasure.new("gold!") }
  let(:sword) { Treasure.new("sword!") }

  describe "greedy" do
    it "takes your treasure" do
      bag = Npc.greedy(platinum).interrogate [platinum]

      bag.wont_include platinum
    end

    it "leaves your treasure alone if you don't have what it wants" do
      bag = Npc.greedy(gold).interrogate [platinum]

      bag.must_include platinum
    end
  end

  describe "generous" do
    it "gives you treasure" do
      bag = Npc.generous(gold).interrogate [platinum]

      bag.must_include platinum
      bag.must_include gold
    end
  end

  describe "stingy" do
    it "gives nothing and takes nothing" do
      bag = Npc.stingy.interrogate [platinum]

      bag.must_include platinum
    end
  end

  describe "shopkeeper" do
    it "exchanges your gold for a sword" do
      bag = Npc.shopkeeper(gold, sword).interrogate [gold]

      bag.must_include sword
      bag.wont_include gold
    end

    it "leaves your other treasure alone" do
      bag = Npc.shopkeeper(gold, sword).interrogate [gold, platinum]

      bag.must_include platinum
    end

    it "kicks you out if you don't have gold" do
      bag = Npc.shopkeeper(gold, sword).interrogate [platinum]

      bag.wont_include sword
      bag.must_include platinum
    end
  end
end
