class Character

  def initialize(name = "Anonymous Character", character_sheet = {})
    @character_sheet = character_sheet
    @character_sheet[:name] = name
  end

  def character_sheet
    # we freeze so that if someone tries to modify the copy
    # that we gave them, they get an error rather than just
    # letting them make a change to the copy and expecting it
    # to affect the character sheet
    @character_sheet.dup.freeze
  end

  def go_on(quest)
    treasure = []
    quest.narrative do |npc|
      treasure = npc.interrogate treasure, self
    end
    treasure
  end
end
