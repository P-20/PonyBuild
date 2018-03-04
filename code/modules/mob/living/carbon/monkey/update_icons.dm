//Monkey Overlays Indexes////////
#define M_MASK_LAYER			1
#define M_BACK_LAYER			2
#define M_HANDCUFF_LAYER		3
#define M_L_HAND_LAYER			4
#define M_R_HAND_LAYER			5
#define TARGETED_LAYER			6
#define M_FIRE_LAYER			6
#define M_TOTAL_LAYERS			7
/////////////////////////////////

/mob/living/carbon/monkey
	var/list/overlays_lying[M_TOTAL_LAYERS]

/mob/living/carbon/monkey/regenerate_icons()
	..()
	update_inv_wear_mask(0)
	update_inv_back(0)
	update_inv_hands(0)
	update_inv_hands(0)
	update_inv_handcuffed(0)
	update_fire(0)
	update_icons()
	//Hud Stuff
	update_hud()
	return

/mob/living/carbon/monkey/update_icons()
	update_hud()
	lying_prev = lying	//so we don't update overlays for lying/standing unless our stance changes again
	overlays.Cut()
	for(var/image/I in overlays_standing)
		overlays += I

	if(lying)
		var/matrix/M = matrix()
		M.Turn(90)
		M.Translate(1,-6)
		src.transform = M
	else
		var/matrix/M = matrix()
		src.transform = M


////////
/mob/living/carbon/monkey/update_inv_wear_mask(var/update_icons=1)
	if( wear_mask && istype(wear_mask, /obj/item/clothing/mask) )
		overlays_standing[M_MASK_LAYER]	= image("icon" = 'icons/mob/monkey.dmi', "icon_state" = "[wear_mask.icon_state]")
		wear_mask.screen_loc = ui_monkey_mask
	else
		overlays_standing[M_MASK_LAYER]	= null
	if(update_icons)		update_icons()


/mob/living/carbon/monkey/update_inv_back(var/update_icons=1)
	if(back)
		overlays_standing[M_BACK_LAYER]	= image("icon" = 'icons/mob/back.dmi', "icon_state" = "[back.icon_state]")
		back.screen_loc = ui_monkey_back
	else
		overlays_standing[M_BACK_LAYER]	= null
	if(update_icons)		update_icons()


/mob/living/carbon/monkey/update_inv_handcuffed(var/update_icons=1)
	if(handcuffed)
		drop_all_hands()
		stop_pulling()
		overlays_standing[M_HANDCUFF_LAYER]	= image("icon" = 'icons/mob/monkey.dmi', "icon_state" = "handcuff1")
	else
		overlays_standing[M_HANDCUFF_LAYER]	= null
	if(update_icons)		update_icons()


/mob/living/carbon/monkey/update_hud()
	if (client)
		client.screen |= contents

//Call when target overlay should be added/removed
/mob/living/carbon/monkey/update_targeted(var/update_icons=1)
	if (targeted_by && target_locked)
		overlays_standing[TARGETED_LAYER]	= target_locked
	else if (!targeted_by && target_locked)
		del(target_locked)
	if (!targeted_by)
		overlays_standing[TARGETED_LAYER]	= null
	if(update_icons)		update_icons()

/mob/living/carbon/monkey/update_fire(var/update_icons=1)
	if(on_fire)
		overlays_standing[M_FIRE_LAYER] = image("icon"='icons/mob/OnFire.dmi', "icon_state"="Standing", "layer"= -M_FIRE_LAYER)
	else
		overlays_standing[M_FIRE_LAYER] = null
	if(update_icons)		update_icons()
//Monkey Overlays Indexes////////
#undef M_MASK_LAYER
#undef M_BACK_LAYER
#undef M_HANDCUFF_LAYER
#undef M_L_HAND_LAYER
#undef M_R_HAND_LAYER
#undef TARGETED_LAYER
#undef M_FIRE_LAYER
#undef M_TOTAL_LAYERS

