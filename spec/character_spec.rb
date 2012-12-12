require 'minitest/autorun'
require 'minitest/spec'

require 'character'
require 'quest'
require 'treasure'

describe Character do
  it "does nothing without a quest" do
    character = Character.new

    treasure = character.go_on(Quest.new)

    treasure.must_be_empty
  end

  it "must have a character sheet" do
    character = Character.new

    character.character_sheet.wont_be_nil
  end

  it "picks up treasure along the quest" do
    character = Character.new
    gold = Treasure.new("gold!")

    treasure = character.go_on(Quest.new(gold))

    assert_includes treasure, gold
  end
end