// Indigo Dusk - Commanders. They are four powerful sweepers, one of each damage type. RED & PALE are aggresive fighters and WHITE & BLACK are leaders which buff allies.
// Previous iteration of them, they were simply 4 strong sweepers which each patrolled around the facility, leading normal sweepers with them.
// They have been changed to this new version as of a rework made during August of 2025.

// This is the base template for a dusk. Never spawn these.



//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS
//BEFORE MERGING THE PR REMEMBER TO REPLACE ALL REFERENCES TO OLD PATHS IN MAPS AND SPAWNERS

/// Base shared type by all Indigo Dusks.
/mob/living/simple_animal/hostile/ordeal/indigo_dusk
	icon = 'ModularTegustation/Teguicons/tegumobs.dmi'
	icon_dead = "sweeper_dead"
	faction = list("indigo_ordeal")
	maxHealth = 1500
	health = 1500
	stat_attack = DEAD
	melee_damage_type = RED_DAMAGE
	rapid_melee = 1
	melee_damage_lower = 13
	melee_damage_upper = 17
	butcher_results = list(/obj/item/food/meat/slab/sweeper = 2)
	guaranteed_butcher_results = list(/obj/item/food/meat/slab/sweeper = 1)
	silk_results = list(/obj/item/stack/sheet/silk/indigo_elegant = 1,
						/obj/item/stack/sheet/silk/indigo_advanced = 2,
						/obj/item/stack/sheet/silk/indigo_simple = 4)
	attack_verb_continuous = "stabs"
	attack_verb_simple = "stab"
	attack_sound = 'sound/effects/ordeals/indigo/stab_1.ogg'
	blood_volume = BLOOD_VOLUME_NORMAL
	can_patrol = TRUE
	var/can_move = TRUE
	var/can_act = TRUE

/// This override adds the mobs that will form part of our squad as we patrol around.
/mob/living/simple_animal/hostile/ordeal/indigo_dusk/Initialize(mapload)
	. = ..()
	var/units_to_add = list(
		/mob/living/simple_animal/hostile/ordeal/indigo_noon = 1,
		)
	AddComponent(/datum/component/ai_leadership, units_to_add)

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/Aggro()
	. = ..()
	a_intent_change(INTENT_HARM)

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/LoseAggro()
	. = ..()
	a_intent_change(INTENT_HELP) //so that they dont get body blocked by their kin outside of combat

/// This override just handles devouring on hit, if possible.
/mob/living/simple_animal/hostile/ordeal/indigo_dusk/AttackingTarget(atom/attacked_target)
	if(!can_act)
		return FALSE
	. = ..()
	if(. && isliving(attacked_target))
		var/mob/living/L = attacked_target
		if(L.stat != DEAD)
			if(L.health <= HEALTH_THRESHOLD_DEAD && HAS_TRAIT(L, TRAIT_NODEATH))
				devour(L)
		else
			devour(L)

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/Move(atom/newloc, dir, step_x, step_y)
	if(!can_move)
		return FALSE
	. = ..()

/// Called when we're eating something to heal.
/mob/living/simple_animal/hostile/ordeal/indigo_dusk/proc/devour(mob/living/L)
	if(!L)
		return FALSE
	visible_message(
		span_danger("[src] devours [L]!"),
		span_userdanger("You feast on [L], restoring your health!"))
	// If we're eating a friendly's dead body (another sweeper), we heal for a flat amount, way less.
	if(faction_check_mob(L))
		SweeperHealing(100)
	else
		SweeperHealing(maxHealth*0.33)
	L.gib()
	return TRUE

/// Prioritizes attacking corpses when injured.
/mob/living/simple_animal/hostile/ordeal/indigo_dusk/PickTarget(list/Targets)
	if(health <= maxHealth * 0.7) // If we're damaged enough
		var/list/highest_priority = list()
		for(var/mob/living/L in Targets)
			if(!CanAttack(L))
				continue
			if(L.health < 0 || L.stat == DEAD)
				highest_priority += L
		if(LAZYLEN(highest_priority))
			return pick(highest_priority)
	var/list/lower_priority = list() // We aren't exactly damaged, but it'd be a good idea to finish the wounded first
	for(var/mob/living/L in Targets)
		if(!CanAttack(L))
			continue
		if(L.health < L.maxHealth*0.5 && (L.stat < UNCONSCIOUS))
			lower_priority += L
	if(LAZYLEN(lower_priority))
		return pick(lower_priority)
	return ..()

/// This is a way to make them eat the corpses of friendlies as they move adjacent to them.
/mob/living/simple_animal/hostile/ordeal/indigo_dusk/PossibleThreats(max_range, consider_attack_condition)
	. = ..()
	if(health <= maxHealth * 0.8)
		for(var/turf/adjacent_turf in orange(1, src))
			for(var/mob/maybe_sweeper_corpse in adjacent_turf)
				if(faction_check_mob(maybe_sweeper_corpse) && maybe_sweeper_corpse.stat == DEAD)
					. |= maybe_sweeper_corpse

/// Used to heal a sweeper and visually express this for clarity.
/mob/living/simple_animal/hostile/ordeal/indigo_dusk/proc/SweeperHealing(amount)
	src.adjustBruteLoss(-amount)
	new /obj/effect/temp_visual/heal(get_turf(src), "#70f54f")

/// Shared base type for the RED and PALE commanders. Don't spawn this in.
/mob/living/simple_animal/hostile/ordeal/indigo_dusk/fighter
	health = 1700
	maxHealth = 1700
	rapid_melee = 1.3
	melee_damage_lower = 40
	melee_damage_upper = 45
	var/special_ability_cooldown = 0
	var/special_ability_cooldown_duration = 10 SECONDS
	var/special_ability_damage = 30
	var/special_ability_activated = FALSE

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/fighter/proc/UseSpecialAbility(mob/living/target = null, mob/living/user = src)
	if(special_ability_cooldown > world.time)
		return FALSE
	special_ability_cooldown = world.time + special_ability_cooldown_duration
	return TRUE

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/fighter/red
	name = "\proper Commander Jacques"
	desc = "A tall humanoid with red claws. They're dripping with blood."
	icon_state = "jacques"
	icon_living = "jacques"
	rapid_melee = 3
	melee_damage_type = RED_DAMAGE
	melee_damage_lower = 15
	melee_damage_upper = 20
	special_ability_cooldown_duration = 20 SECONDS
	special_ability_damage = 25
	var/time_between_trash_disposal_hits = 1 SECONDS
	var/max_trash_disposal_hits = 8

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/fighter/red/AttackingTarget(atom/attacked_target)
	if(UseSpecialAbility(attacked_target))
		return FALSE
	. = ..()

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/fighter/red/UseSpecialAbility(mob/living/target = null, mob/living/user = src)
	if(..() && target)
		INVOKE_ASYNC(src, PROC_REF(TrashDisposalTelegraph), target, user)
		return TRUE
	return FALSE

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/fighter/red/proc/TrashDisposalTelegraph(mob/living/target, mob/living/user = src)
	var/obj/effect/temp_visual/trash_disposal_telegraph/warning = new /obj/effect/temp_visual/trash_disposal_telegraph(get_turf(user))
	say("+5363 23 625 513 93477 2576!+")
	walk_towards(warning, target, 0.1 SECONDS)
	can_act = FALSE
	can_move = FALSE
	SLEEP_CHECK_DEATH(2 SECONDS)
	AIStatus = AI_OFF
	special_ability_activated = TRUE
	can_move = TRUE
	can_act = TRUE
	user.throw_at(target, 10, 5, src, FALSE)
	user.visible_message(span_danger("[user] leaps at [target]!"))
	addtimer(CALLBACK(src, PROC_REF(StopLunging)), 2 SECONDS)

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/fighter/red/proc/TrashDisposalInitiate(mob/living/target, mob/living/user = src)
	var/mob/living/carbon/human/human_trash
	var/mob/living/simple_animal/animal_trash
	if(ishuman(target))
		human_trash = target
		human_trash.Paralyze(8 SECONDS)
	else if(istype(target, /mob/living/simple_animal))
		animal_trash = target
		animal_trash.AIStatus = AI_OFF
	target.visible_message(span_danger("[target] is pinned down by [src]!"), span_userdanger("You're pinned down by [src]!"))
	var/turf/target_deathbed = get_turf(target)
	new /obj/effect/temp_visual/weapon_stun(target_deathbed)
	src.forceMove(target_deathbed)
	can_move = FALSE
	can_act = FALSE
	say("3462 7239...")
	INVOKE_ASYNC(src, PROC_REF(TrashDisposalHit), target, user, 1)

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/fighter/red/proc/TrashDisposalHit(mob/living/target, mob/living/user = src, hit_count)
	if(do_after(user, time_between_trash_disposal_hits))
		user.do_attack_animation(target)
		playsound(user, attack_sound, 100, TRUE)
		new /obj/effect/gibspawner/generic/trash_disposal(get_turf(target))
		target.deal_damage(special_ability_damage, melee_damage_type)
		SweeperHealing(special_ability_damage)
		user.visible_message(span_danger("[user] rips into [target] and refuels themselves with their blood!"))
		time_between_trash_disposal_hits -= 1
		special_ability_damage += 4
		if(hit_count >= max_trash_disposal_hits)
			TrashDisposalCleanup(target, user)
			return TRUE

		INVOKE_ASYNC(src, PROC_REF(TrashDisposalHit), target, user, hit_count + 1)
		return TRUE
	TrashDisposalCleanup(target, user)
	return FALSE

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/fighter/red/proc/TrashDisposalCleanup(mob/living/target, mob/living/user = src)
	can_act = TRUE
	can_move = TRUE
	AIStatus = AI_ON
	special_ability_activated = FALSE
	time_between_trash_disposal_hits = initial(time_between_trash_disposal_hits)
	special_ability_damage = initial(special_ability_damage)

	if(ishuman(target))
		var/mob/living/carbon/human/freed_human = target
		freed_human.remove_status_effect(STATUS_EFFECT_PARALYZED)
		freed_human.visible_message(span_danger("[freed_human] escapes [src]'s pin!"))
		return
	if(istype(target, /mob/living/simple_animal))
		var/mob/living/simple_animal/freed_animal = target
		freed_animal.AIStatus = AI_ON
		return

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/fighter/red/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(isliving(hit_atom) && special_ability_activated)
		special_ability_activated = FALSE
		can_act = FALSE
		INVOKE_ASYNC(src, PROC_REF(TrashDisposalInitiate), hit_atom, src)
	. = ..()

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/fighter/red/proc/StopLunging()
	special_ability_activated = FALSE
	AIStatus = AI_ON

/obj/effect/temp_visual/trash_disposal_telegraph
	name = "Trash Designator Circle"
	icon = 'icons/mob/telegraphing/telegraph_holographic.dmi'
	icon_state = "target_circle"
	desc = "Uh oh."
	duration = 2.2 SECONDS
	randomdir = FALSE

/obj/effect/gibspawner/generic/trash_disposal
	gibamounts = list(1, 1, 1)
	sound_vol = 30


/mob/living/simple_animal/hostile/ordeal/indigo_dusk/fighter/pale


/mob/living/simple_animal/hostile/ordeal/indigo_dusk/officer


/mob/living/simple_animal/hostile/ordeal/indigo_dusk/officer/white
	name = "\proper Commander Adelheide"
	maxHealth = 2100
	health = 2100
	desc = "A tall humanoid with a white greatsword."
	icon_state = "adelheide"
	icon_living = "adelheide"
	melee_damage_type = WHITE_DAMAGE
	melee_damage_lower = 42
	melee_damage_upper = 55
	damage_coeff = list(RED_DAMAGE = 0.7, WHITE_DAMAGE = 0.5, BLACK_DAMAGE = 1.5, PALE_DAMAGE = 0.7)
	guaranteed_butcher_results = list(/obj/item/food/meat/slab/sweeper = 1)

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/white/Initialize(mapload)
	. = ..()
	if(SSmaptype.maptype in SSmaptype.citymaps)
		guaranteed_butcher_results += list(/obj/item/head_trophy/indigo_head/white = 1)

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/white/CanAttack(atom/the_target)
	if(ishuman(the_target))
		var/mob/living/carbon/human/L = the_target
		if(L.sanity_lost && L.stat != DEAD)
			return FALSE
	return ..()

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/officer/black
	name = "\proper Commander Maria"
	desc = "A tall humanoid with a large black hammer."
	icon_state = "maria"
	icon_living = "maria"
	melee_damage_type = BLACK_DAMAGE
	melee_damage_lower = 42
	melee_damage_upper = 55
	damage_coeff = list(RED_DAMAGE = 0.7, WHITE_DAMAGE = 0.7, BLACK_DAMAGE = 0.5, PALE_DAMAGE = 1.5)
	guaranteed_butcher_results = list(/obj/item/food/meat/slab/sweeper = 1)

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/black/Initialize(mapload)
	. = ..()
	if(SSmaptype.maptype in SSmaptype.citymaps)
		guaranteed_butcher_results += list(/obj/item/head_trophy/indigo_head/black = 1)

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/red
	name = "\proper Commander Jacques"
	desc = "A tall humanoid with red claws."
	icon_state = "jacques"
	icon_living = "jacques"
	rapid_melee = 4
	melee_damage_type = RED_DAMAGE
	damage_coeff = list(RED_DAMAGE = 0.5, WHITE_DAMAGE = 1.5, BLACK_DAMAGE = 0.7, PALE_DAMAGE = 0.7)
	guaranteed_butcher_results = list(/obj/item/food/meat/slab/sweeper = 1)

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/red/Initialize(mapload)
	. = ..()
	if(SSmaptype.maptype in SSmaptype.citymaps)
		guaranteed_butcher_results += list(/obj/item/head_trophy/indigo_head = 1)


/mob/living/simple_animal/hostile/ordeal/indigo_dusk/pale
	name = "\proper Commander Silvina"
	desc = "A tall humanoid with glowing pale fists."
	icon_state = "silvina"
	icon_living = "silvina"
	rapid_melee = 2
	melee_damage_type = PALE_DAMAGE
	damage_coeff = list(RED_DAMAGE = 1.5, WHITE_DAMAGE = 0.7, BLACK_DAMAGE = 0.7, PALE_DAMAGE = 0.5)
	guaranteed_butcher_results = list(/obj/item/food/meat/slab/sweeper = 1)

/mob/living/simple_animal/hostile/ordeal/indigo_dusk/pale/Initialize(mapload)
	. = ..()
	if(SSmaptype.maptype in SSmaptype.citymaps)
		guaranteed_butcher_results += list(/obj/item/head_trophy/indigo_head/pale = 1)

