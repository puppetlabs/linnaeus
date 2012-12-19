class Instruction
  DoNotTouch = ->(character_treasure, npc_treasure) { character_treasure }
  AlwaysGive = ->(character_treasure, npc_treasure) { character_treasure + [npc_treasure] }
  AlwaysTake = ->(character_treasure, npc_treasure) { character_treasure - [npc_treasure] }
end
