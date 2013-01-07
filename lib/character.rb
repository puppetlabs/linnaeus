class Character
  attr_accessor :character_sheet

  def initialize(name = "Anonymous Character")
    @character_sheet = {}
    @character_sheet[:name] = name
  end

  def go_on(quest)
    treasure = []
    quest.narrative do |npc|
      treasure = npc.interrogate treasure, self
    end
    treasure
  end
end
