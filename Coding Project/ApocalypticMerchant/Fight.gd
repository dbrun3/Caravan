class_name Fight
extends Node
# This class just provides static helper functions for fight functionality

class MyCustomSorter:
	static func sort_weapons(weapon1: Item, weapon2: Item):
		if weapon1.itemDamage > weapon2.itemDamage:
			return true
		return false

static func calculate_fight_win_probability() -> int:
	# Get the base skill level of the player and NPC
	var player_base_skill = Global.player.combatSkill
	var player_skill_bonus = 0 # any bonus the player might get from having weapons + ammo
	var character_skill = Global.current_character.combatSkill
	
	# Get Weapons and Ammo the player possesses
	var player_weapons = [] # list of Items (weapons type)
	var player_ammo = [] # list of Strings (names of ammos player has)
	for item in Global.player.inventory:
		if item.get_type() == "weapons":
			player_weapons.append(item)
		elif item.get_type() == "ammo":
			player_ammo.append(item.get_name())
	
	# Calculate any bonuses from weapons/ammo
	player_weapons.sort_custom(MyCustomSorter, "sort_weapons") # sort weapons in descending order by damage
	for weapon in player_weapons:
		if player_ammo.has(weapon.itemAmmo) or weapon.itemAmmo == "none": # player has the ammo for that weapon
			player_skill_bonus = weapon.itemDamage # set the bonus to the weapon's damage
			Global.player.remove_item(weapon.itemAmmo)
			break # no need to look at any further weapons, bonus is set
	
	# Get player's final skill for the fight
	var player_skill = player_base_skill + player_skill_bonus
	
	# Return the probability of fight success
	var fight_success:int # percentage chance of success in the fight
	
	if player_skill == 0 and character_skill == 0: # avoid divide by 0
		fight_success = 50
	else:
		fight_success = int(float(player_skill * 100) / (player_skill + character_skill))
		
	return fight_success
