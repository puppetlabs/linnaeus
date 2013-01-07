require 'minitest/autorun'
require 'minitest/spec'

require 'treasure'
require 'npc'
require 'instruction'
require 'matchers'

describe Npc do
  include Matchers

  let(:platinum) { Treasure.new("platinum!") }
  let(:gold) { Treasure.new("gold!") }
  let(:sword) { Treasure.new("sword!") }
  let(:bob) { Character.new("bob") }

  describe "greedy" do
    it "takes your treasure" do
      bag = Npc.greedy(platinum).interrogate [platinum], bob

      bag.wont_include platinum
    end

    it "leaves your treasure alone if you don't have what it wants" do
      bag = Npc.greedy(gold).interrogate [platinum], bob

      bag.must_include platinum
    end

    describe "when matcher specified" do
      describe "when character matches" do
        it "takes your treasure if character matches" do
          bag = Npc.greedy(platinum, :when => has(:name, is("bob"))).interrogate [platinum], bob

          bag.wont_include platinum
        end

        it "leaves your treasure alone if doesn't have what it wants" do
          bag = Npc.greedy(gold, :when => has(:name, is("bob"))).interrogate [platinum], bob

          bag.must_include platinum
        end
      end

      describe "when character is someone else" do
        it "leaves your treasure alone" do
          bag = Npc.greedy(platinum, :when => has(:name, is("frank"))).interrogate [platinum], bob

          bag.must_include platinum
        end
      end

      describe "when character aint you" do
        it "leaves your treasure alone" do
          bag = Npc.greedy(platinum, :when => has(:name, is("frank"))).interrogate [platinum], bob

          bag.must_include platinum
        end
      end
    end
  end

  describe "generous" do
    it "gives you treasure" do
      bag = Npc.generous(gold).interrogate [platinum], bob

      bag.must_include platinum
      bag.must_include gold
    end

    describe "when matcher specified" do
      describe "when character matches" do
        it "gives you treasure" do
          bag = Npc.generous(gold, :when => has(:name, is("bob"))).interrogate [platinum], bob
          bag.must_include platinum
          bag.must_include gold
        end
      end

      describe "when character is someone else" do
        it "gives nothing" do
          bag = Npc.generous(gold, :when => has(:name, is("frank"))).interrogate [platinum], bob
          bag.must_include platinum
          bag.wont_include gold
        end
      end

      describe "when character aint you" do
        it "gives nothing" do
          bag = Npc.generous(gold, :when => has(:name, aint("bob"))).interrogate [platinum], bob
          bag.must_include platinum
          bag.wont_include gold
        end
      end

    end
  end

  describe "stingy" do
    it "gives nothing and takes nothing" do
      bag = Npc.stingy.interrogate [platinum], bob

      bag.must_include platinum
    end
  end

  describe "shopkeeper" do
    it "exchanges your gold for a sword" do
      bag = Npc.shopkeeper(gold, sword).interrogate [gold], bob

      bag.must_include sword
      bag.wont_include gold
    end

    it "leaves your other treasure alone" do
      bag = Npc.shopkeeper(gold, sword).interrogate [gold, platinum], bob

      bag.must_include platinum
    end

    it "kicks you out if you don't have gold" do
      bag = Npc.shopkeeper(gold, sword).interrogate [platinum], bob

      bag.wont_include sword
      bag.must_include platinum
    end

    describe "when matcher specified" do
      describe "when character matches" do
        it "exchances your gold for a sword" do
          bag = Npc.shopkeeper(gold, sword, :when => has(:name, is("bob"))).interrogate [gold, platinum], bob

          bag.must_include sword
          bag.wont_include gold
        end

        it "leaves your other treasure alone" do
          bag = Npc.shopkeeper(gold, sword, :when => has(:name, is("bob"))).interrogate [gold, platinum], bob

          bag.must_include platinum
        end
      end

      describe "when character is someone else" do
        it "doesn't exchange your gold for a sword" do
          bag = Npc.shopkeeper(gold, sword, :when => has(:name, is("frank"))).interrogate [gold, platinum], bob

          bag.must_include gold
          bag.wont_include sword
        end

        it "leaves your other treasure alone" do
          bag = Npc.shopkeeper(gold, sword, :when => has(:name, is("frank"))).interrogate [gold, platinum], bob

          bag.must_include platinum
        end
      end

      describe "when character aint you" do
        it "doesn't exchange your gold for a sword" do
          bag = Npc.shopkeeper(gold, sword, :when => has(:name, aint("bob"))).interrogate [gold, platinum], bob

          bag.must_include gold
          bag.wont_include sword
        end

        it "leaves your other treasure alone" do
          bag = Npc.shopkeeper(gold, sword, :when => has(:name, aint("bob"))).interrogate [gold, platinum], bob

          bag.must_include platinum
        end
      end
    end
  end
end
