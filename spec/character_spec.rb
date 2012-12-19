require 'minitest/autorun'
require 'minitest/spec'

require 'character'
require 'quest'
require 'treasure'
require 'npc'
require 'instruction'

describe Character do
  let(:gold) { Treasure.new("gold!") }
  let(:silver) { Treasure.new("silver!") }
  let(:bronze) { Treasure.new("bronze!") }

  let(:character) { Character.new }

  it "does nothing without a quest" do
    treasure_bag = character.go_on(Quest.new)

    treasure_bag.must_be_empty
  end

  it "must have a character sheet" do
    character.character_sheet.wont_be_nil
  end

  it "keeps treasure given to it" do
    treasure_bag = character.go_on(Quest.new(Npc.generous(gold)))

    assert_includes treasure_bag, gold
  end

  it "leaves treasure it cannot take" do
    treasure_bag = character.go_on(Quest.new(Npc.stingy))

    treasure_bag.must_be_empty
  end

  it "collects all treasure it is able to pick up" do
    treasure_bag = character.go_on(Quest.new(Npc.generous(gold), Npc.stingy, Npc.generous(bronze)))

    treasure_bag.must_include gold
    treasure_bag.must_include bronze
    treasure_bag.wont_include silver
  end
end
