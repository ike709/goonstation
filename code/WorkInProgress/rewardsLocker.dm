/datum/achievementReward
	var/title = ""
	var/desc = ""
	var/required_medal = null
	var/once_per_round = 1   //Can only be claimed once per round.
	var/mobonly = 1 //If the reward can only be redeemed if the player has a /mob/living.


	proc/rewardActivate(var/mob/activator) //Called when the reward is claimed from the locker. Spawn item here / give verbs here / do whatever for reward.
		boutput(activator, "This reward is undefined. Please inform a coder.")
		return							   //You could even make one-time reward by stripping their medal here.

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Rewards below
/datum/achievementReward/satchel
	title = "(Skin) Satchel"
	desc = "Converts whatever backpack you're wearing into a satchel. Requires that you're wearing a backpack."
	required_medal = "Fish"
	once_per_round = 0

	rewardActivate(var/mob/activator)
		if (!istype(activator))
			return

		if (!activator.back)
			boutput(activator, "<span style=\"color:red\">You can't reskin a backpack if you're not wearing one!</span>")
			return

		if (istype(activator.back, /obj/item/storage/backpack/medic))
			var/obj/item/storage/backpack/medic/M = activator.back
			var/prev1 = M.name
			M.icon = 'icons/obj/storage.dmi'
			M.inhand_image_icon = 'icons/mob/inhand/hand_general.dmi'
			if (M.inhand_image) M.inhand_image.icon = 'icons/mob/inhand/hand_general.dmi'
			M.wear_image_icon = 'icons/mob/back.dmi'
			if (M.wear_image) M.wear_image.icon = 'icons/mob/back.dmi'
			M.icon_state = "satchel_medic"
			M.item_state = "backpack"
			M.name = "medic's satchel"
			M.real_name = "medic's satchel"
			M.desc = "A thick, wearable container made of synthetic fibers, able to carry a number of objects comfortably on a crewmember's shoulder. (Base Item: [prev1])"
			activator.set_clothing_icon_dirty()

		else if (istype(activator.back, /obj/item/storage/backpack/NT))
			var/obj/item/storage/backpack/NT/M = activator.back
			var/prev2 = M.name
			M.icon = 'icons/obj/storage.dmi'
			M.inhand_image_icon = 'icons/mob/inhand/hand_general.dmi'
			if (M.inhand_image) M.inhand_image.icon = 'icons/mob/inhand/hand_general.dmi'
			M.wear_image_icon = 'icons/mob/back.dmi'
			if (M.wear_image) M.wear_image.icon = 'icons/mob/back.dmi'
			M.icon_state = "NTsatchel"
			M.item_state = "backpack"
			M.name = "NT satchel"
			M.real_name = "NT satchel"
			M.desc = "A thick, wearable container made of synthetic fibers, able to carry a number of objects comfortably on a crewmember's shoulder. (Base Item: [prev2])"
			activator.set_clothing_icon_dirty()

		else if (istype(activator.back, /obj/item/storage/backpack))
			var/obj/item/storage/backpack/M = activator.back
			var/prev3 = M.name
			M.icon = 'icons/obj/storage.dmi'
			M.inhand_image_icon = 'icons/mob/inhand/hand_general.dmi'
			if (M.inhand_image) M.inhand_image.icon = 'icons/mob/inhand/hand_general.dmi'
			M.wear_image_icon = 'icons/mob/back.dmi'
			if (M.wear_image) M.wear_image.icon = 'icons/mob/back.dmi'
			M.icon_state = "satchel"
			M.item_state = "backpack"
			M.name = "satchel"
			M.real_name = "satchel"
			M.desc = "A thick, wearable container made of synthetic fibers, able to carry a number of objects comfortably on a crewmember's shoulder. (Base Item: [prev3])"
			activator.set_clothing_icon_dirty()

		else
			boutput(activator, "<span style=\"color:red\">Whatever it is you've got on your back, it can't be reskinned!</span>")
			return

		return

/datum/achievementReward/hightechpodskin
	title = "(Skin) HighTech Pod"
	desc = "Gives you a Kit that allows you to change the appearance of a Pod."
	required_medal = "Newton's Crew"

	rewardActivate(var/mob/activator)
		boutput(usr, "<span style=\"color:blue\">The Kit has been dropped at your current location.</span>")
		new /obj/item/pod/paintjob/tronthing(get_turf(activator))
		return

/datum/achievementReward/swatgasmask
	title = "(Skin) SWAT Gas Mask"
	desc = "Turns your Gas Mask into a SWAT Gas Mask. If you're wearing one."
	required_medal = "Leave no man behind!"

	rewardActivate(var/mob/activator)
		if (!istype(activator))
			return

		if (activator.wear_mask && istype(activator.wear_mask, /obj/item/clothing/mask/gas))
			var/obj/item/clothing/mask/gas/emergency/M = activator.wear_mask
			M.icon_state = "swat"
			//M.item_state = "swat"
			M.name = "SWAT Gas Mask"
			M.real_name = "SWAT Gas Mask"
			M.desc = "A snazzy-looking black Gas Mask."
			activator.set_clothing_icon_dirty()
		return

/datum/achievementReward/colorfulberet
	title = "(Skin) Colorful Beret"
	desc = "Turns your hat into a colorful beret. If you're wearing one."
	required_medal = "Monkey Duty"

	rewardActivate(var/mob/activator)
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			if (!istype(H.head, /obj/item/clothing/head/helmet) && istype(H.head, /obj/item/clothing/head)) // ha...
				var/obj/item/clothing/head/M = H.head
				M.icon_state = "beret_base"
				M.wear_image_icon = 'icons/mob/head.dmi'
				M.color = random_saturated_hex_color(1)
				M.name = "beret"
				M.real_name = "beret"
				M.desc = "A colorful beret."
				activator.set_clothing_icon_dirty()
		return

/datum/achievementReward/round_flask
	title = "(Skin) Round-bottom Flask"
	desc = "Requires you to be holding a large beaker."
	required_medal = "We didn't start the fire"
	once_per_round = 0

	rewardActivate(var/mob/activator)
		if (!istype(activator))
			return

		if (istype(activator.l_hand, /obj/item/reagent_containers/glass/beaker/large))
			var/obj/item/reagent_containers/glass/beaker/large/M = activator.l_hand
			var/prev = M.name
			M.name = "round-bottom flask"
			M.desc = "A large round-bottom flask, for all your chemistry needs. (Base Item: [prev])"
			M.icon_style = "flask"
			M.item_state = "flask"
			M.fluid_image = image(M.icon, "fluid-flask")
			M.update_icon()
			activator.set_clothing_icon_dirty()

		else if (istype(activator.r_hand, /obj/item/reagent_containers/glass/beaker/large))
			var/obj/item/reagent_containers/glass/beaker/large/M = activator.r_hand
			var/prev = M.name
			M.name = "round-bottom flask"
			M.desc = "A large round-bottom flask, for all your chemistry needs. (Base Item: [prev])"
			M.icon_style = "flask"
			M.item_state = "flask"
			M.fluid_image = image(M.icon, "fluid-flask")
			M.update_icon()
			activator.set_clothing_icon_dirty()

		else
			boutput(activator, "<span style=\"color:red\">You need to be holding a large beaker in order to claim this reward!</span>")
			return

		return

/datum/achievementReward/red_bucket
	title = "(Skin) Red Bucket"
	desc = "Requires you to be holding a bucket."
	required_medal = "Spotless"
	once_per_round = 1

	rewardActivate(var/mob/activator)
		if (!istype(activator))
			return

		if (istype(activator.l_hand, /obj/item/reagent_containers/glass/bucket))
			var/obj/item/reagent_containers/glass/bucket/M = activator.l_hand
			var/obj/item/reagent_containers/glass/bucket/red/new_bucket = new /obj/item/reagent_containers/glass/bucket/red(get_turf(activator))
			new_bucket.reagents = M.reagents
			new_bucket.fingerprints = M.fingerprints
			new_bucket.fingerprintshidden = M.fingerprintshidden
			new_bucket.fingerprintslast = M.fingerprintslast
			M.reagents = null
			M.fingerprints = null
			M.fingerprintshidden = null
			M.fingerprintslast = null
			qdel(M)
			activator.put_in_hand(new_bucket, 1)

		else if (istype(activator.r_hand, /obj/item/reagent_containers/glass/bucket))
			var/obj/item/reagent_containers/glass/bucket/M = activator.r_hand
			var/obj/item/reagent_containers/glass/bucket/red/new_bucket = new /obj/item/reagent_containers/glass/bucket/red(get_turf(activator))
			new_bucket.reagents = M.reagents
			new_bucket.fingerprints = M.fingerprints
			new_bucket.fingerprintshidden = M.fingerprintshidden
			new_bucket.fingerprintslast = M.fingerprintslast
			M.reagents = null
			M.fingerprints = null
			M.fingerprintshidden = null
			M.fingerprintslast = null
			qdel(M)
			activator.put_in_hand(new_bucket, 0)

		else
			boutput(activator, "<span style=\"color:red\">You need to be holding a bucket in order to claim this reward!</span>")
			return

		return

/datum/achievementReward/pilotuniform
	title = "(Skin) Pilot Suit"
	desc = "Requires that you wear something in your jumpsuit slot."
	required_medal = "It's not 'Door to Heaven'"

	rewardActivate(var/mob/activator)
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			if (H.w_uniform)
				var/obj/item/clothing/M = H.w_uniform
				var/prev = M.name
				M.icon = 'icons/obj/clothing/uniforms/item_js_misc.dmi'
				M.inhand_image_icon = 'icons/mob/inhand/jumpsuit/hand_js_misc.dmi'
				if (M.inhand_image) M.inhand_image.icon = 'icons/mob/inhand/jumpsuit/hand_js_misc.dmi'
				M.wear_image_icon = 'icons/mob/jumpsuits/worn_js_misc.dmi'
				if (M.wear_image) M.wear_image.icon = 'icons/mob/jumpsuits/worn_js_misc.dmi'
				M.icon_state = "mechanic"
				M.item_state = "mechanic"
				M.name = "pilot suit"
				M.real_name = "pilot suit"
				M.desc = "A sleek but comfortable pilot's jumpsuit. (Base Item: [prev])"
				H.set_clothing_icon_dirty()
		return

/datum/achievementReward/flower_scrubs
	title = "(Skin) Flower Scrubs"
	desc = "Requires that you wear medical scrubs in your jumpsuit slot."
	required_medal = "Primum non nocere"
	once_per_round = 0

	rewardActivate(var/mob/activator)
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			if (H.w_uniform)
				var/obj/item/clothing/under/scrub/M = H.w_uniform
				if (!istype(M))
					boutput(activator, "<span style=\"color:red\">You're not wearing medical scrubs!</span>")
					return
				var/prev = M.name
				M.icon = 'icons/obj/clothing/uniforms/item_js_misc.dmi'
				M.inhand_image_icon = 'icons/mob/inhand/jumpsuit/hand_js.dmi'
				if (M.inhand_image) M.inhand_image.icon = 'icons/mob/inhand/jumpsuit/hand_js.dmi'
				M.wear_image_icon = 'icons/mob/jumpsuits/worn_js_misc.dmi'
				if (M.wear_image) M.wear_image.icon = 'icons/mob/jumpsuits/worn_js_misc.dmi'
				M.icon_state = "scrub-f"
				M.item_state = "lightblue"
				M.name = "flower scrubs"
				M.real_name = "flower scrubs"
				M.desc = "Man, these scrubs look pretty nice. (Base Item: [prev])"
				H.set_clothing_icon_dirty()
		return

/datum/achievementReward/stylish
	title = "(Skin) Relic Security Jumpsuit"
	desc = "Requires that you wear a security officer or Head of Security uniform in your jumpsuit slot."
	required_medal = "Dead or alive, you're coming with me"

	rewardActivate(var/mob/activator)
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			if (H.w_uniform)
				var/obj/item/clothing/under/rank/M = H.w_uniform
				if (istype(M, /obj/item/clothing/under/rank/head_of_securityold))
					M.icon_state = "hos-old"
				else if (istype(M, /obj/item/clothing/under/rank/security))
					M.icon_state = "security-old"
				H.set_clothing_icon_dirty()

		return

/datum/achievementReward/med_labcoat
	title = "(Skin) Medical Labcoat"
	desc = "Requires that you wear a labcoat in your suit slot."
	required_medal = "Patchwork"
	once_per_round = 0

	rewardActivate(var/mob/activator)
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			if (H.wear_suit)
				var/obj/item/clothing/suit/labcoat/M = H.wear_suit
				if (!istype(M))
					boutput(activator, "<span style=\"color:red\">You're not wearing a labcoat!</span>")
					return
				var/prev = M.name
				M.icon = 'icons/obj/clothing/overcoats/item_suit.dmi'
				M.inhand_image_icon = 'icons/mob/inhand/inhand_cl_suit.dmi'
				if (M.inhand_image) M.inhand_image.icon = 'icons/mob/inhand/inhand_cl_suit.dmi'
				M.wear_image_icon = 'icons/mob/overcoats/worn_suit.dmi'
				if (M.wear_image) M.wear_image.icon = 'icons/mob/overcoats/worn_suit.dmi'
				M.icon_state = findtext(M.icon_state, "_o") ? "MDlabcoat_o" : "MDlabcoat"
				M.item_state = "MDlabcoat"
				M.coat_style = "MDlabcoat"
				M.name = "doctor's labcoat"
				M.real_name = "doctor's labcoat"
				M.desc = "A protective laboratory coat with the red markings of a Medical Doctor. (Base Item: [prev])"
				H.set_clothing_icon_dirty()
		return

/datum/achievementReward/sci_labcoat
	title = "(Skin) Science Labcoat"
	desc = "Requires that you wear a labcoat in your suit slot."
	required_medal = "Meth is a hell of a drug"
	once_per_round = 0

	rewardActivate(var/mob/activator)
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			if (H.wear_suit)
				var/obj/item/clothing/suit/labcoat/M = H.wear_suit
				if (!istype(M))
					boutput(activator, "<span style=\"color:red\">You're not wearing a labcoat!</span>")
					return
				var/prev = M.name
				M.icon = 'icons/obj/clothing/overcoats/item_suit.dmi'
				M.inhand_image_icon = 'icons/mob/inhand/inhand_cl_suit.dmi'
				if (M.inhand_image) M.inhand_image.icon = 'icons/mob/inhand/inhand_cl_suit.dmi'
				M.wear_image_icon = 'icons/mob/overcoats/worn_suit.dmi'
				if (M.wear_image) M.wear_image.icon = 'icons/mob/overcoats/worn_suit.dmi'
				M.icon_state = findtext(M.icon_state, "_o") ? "SCIlabcoat_o" : "SCIlabcoat"
				M.item_state = "SCIlabcoat"
				M.coat_style = "SCIlabcoat"
				M.name = "scientist's labcoat"
				M.real_name = "scientist's labcoat"
				M.desc = "A protective laboratory coat with the purple markings of a Scientist. (Base Item: [prev])"
				H.set_clothing_icon_dirty()
		return

/datum/achievementReward/alchemistrobes
	title = "(Skin) Grand Alchemist's Robes"
	desc = "Requires that you wear a labcoat in your suit slot."
	required_medal = "Illuminated"
	once_per_round = 0

	rewardActivate(var/mob/activator)
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			if (H.wear_suit)
				var/obj/item/clothing/suit/labcoat/M = H.wear_suit
				if (!istype(M))
					boutput(activator, "<span style=\"color:red\">You're not wearing a labcoat!</span>")
					return
				var/prev = M.name
				M.icon = 'icons/obj/clothing/overcoats/item_suit.dmi'
				M.inhand_image_icon = 'icons/mob/inhand/inhand_cl_suit.dmi'
				if (M.inhand_image) M.inhand_image.icon = 'icons/mob/inhand/inhand_cl_suit.dmi'
				M.wear_image_icon = 'icons/mob/overcoats/worn_suit.dmi'
				if (M.wear_image) M.wear_image.icon = 'icons/mob/overcoats/worn_suit.dmi'
				M.icon_state = findtext(M.icon_state, "_o") ? "alchrobe_o" : "alchrobe"
				M.item_state = "alchrobe"
				M.coat_style = "alchrobe"
				M.name = "grand alchemist's robes"
				M.real_name = "grand alchemist's robes"
				M.desc = "Well you sure LOOK the part with these on. (Base Item: [prev])"
				H.set_clothing_icon_dirty()
		return

/datum/achievementReward/dioclothes
	title = "(Skin) Strange Vampire Outfit"
	desc = "Requires that you wear something in your suit slot."
	required_medal = "Dracula Jr."

	rewardActivate(var/mob/activator)
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			if (H.wear_suit)
				var/obj/item/clothing/M = H.wear_suit
				if (istype(M, /obj/item/clothing/suit/wizrobe))
					boutput(activator, "Your magic-infused robes resist the meta-telelogical energies!")
					return
				if (istype(M, /obj/item/clothing/suit/space/industrial/syndicate) || istype(M, /obj/item/clothing/suit/space/syndicate))
					boutput(activator, "Nyet, comrade.")
					return
				var/prev = M.name
				M.icon = 'icons/obj/clothing/overcoats/item_suit.dmi'
				M.inhand_image_icon = 'icons/mob/inhand/inhand_cl_suit.dmi'
				if (M.inhand_image) M.inhand_image.icon = 'icons/mob/inhand/inhand_cl_suit.dmi'
				M.wear_image_icon = 'icons/mob/overcoats/worn_suit.dmi'
				if (M.wear_image) M.wear_image.icon = 'icons/mob/overcoats/worn_suit.dmi'
				M.icon_state = "vclothes"
				M.item_state = "vclothes"
				if (istype(M, /obj/item/clothing/suit/labcoat))
					var/obj/item/clothing/suit/labcoat/L = M
					L.coat_style = null
				M.name = "strange vampire outfit"
				M.real_name = "strange vampire outfit"
				M.desc = "How many breads <i>have</i> you eaten in your life? It's a good question. (Base Item: [prev])"
				H.set_clothing_icon_dirty()
		return

/datum/achievementReward/inspectorscloths
	title = "(Skin set) Inspector's Clothes"
	desc = "Requires that you wear something in your suit and jumpsuit slots."
	required_medal = "Neither fashionable noir stylish"

	rewardActivate(var/mob/activator)
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator
			if (H.wear_suit)
				var/obj/item/clothing/M = H.wear_suit
				if (istype(M, /obj/item/clothing/suit/wizrobe))
					boutput(activator, "Your magic-infused robes resist the meta-telelogical energies!")
					return
				if (istype(M, /obj/item/clothing/suit/space/industrial/syndicate) || istype(M, /obj/item/clothing/suit/space/syndicate))
					boutput(activator, "Nyet, comrade.")
					return
				var/prev = M.name
				M.icon = 'icons/obj/clothing/overcoats/item_suit.dmi'
				M.inhand_image_icon = 'icons/mob/inhand/inhand_cl_suit.dmi'
				if (M.inhand_image) M.inhand_image.icon = 'icons/mob/inhand/inhand_cl_suit.dmi'
				M.wear_image_icon = 'icons/mob/overcoats/worn_suit.dmi'
				if (M.wear_image) M.wear_image.icon = 'icons/mob/overcoats/worn_suit.dmi'
				if (istype(M, /obj/item/clothing/suit/labcoat))
					var/obj/item/clothing/suit/labcoat/L = M
					M.icon_state = findtext(M.icon_state, "_o") ? "inspectorc_o" : "inspectorc"
					L.coat_style = "inspectorc"
				else
					M.icon_state = "inspectorc_o"
				M.item_state = "inspectorc"
				M.name = "inspector's short coat"
				M.real_name = "inspector's short coat"
				M.desc = "A coat for the modern detective. (Base Item: [prev])"
				H.set_clothing_icon_dirty()

			if (H.w_uniform)
				var/obj/item/clothing/M = H.w_uniform
				var/prev2 = M.name
				M.icon = 'icons/obj/clothing/uniforms/item_js_misc.dmi'
				M.inhand_image_icon = 'icons/mob/inhand/jumpsuit/hand_js_misc.dmi'
				if (M.inhand_image) M.inhand_image.icon = 'icons/mob/inhand/jumpsuit/hand_js_misc.dmi'
				M.wear_image_icon = 'icons/mob/jumpsuits/worn_js_misc.dmi'
				if (M.wear_image) M.wear_image.icon = 'icons/mob/jumpsuits/worn_js_misc.dmi'
				M.icon_state = "inspectorj"
				M.item_state = "viceG"
				M.name = "inspector's uniform"
				M.real_name = "inspector's uniform"
				M.desc = "A uniform for the modern detective. (Base Item: [prev2])"
				H.set_clothing_icon_dirty()
		return

/datum/achievementReward/ntso_commander
	title = "(Skin set) NT-SO Commander Uniform"
	desc = "Will change the skin of captain hats, captain armor/spacesuits and captain uniforms."
	required_medal = "Icarus"
	once_per_round = 0

	rewardActivate(var/mob/activator)
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator

			if (H.w_uniform)
				var/obj/item/clothing/M = H.w_uniform
				if (istype(M, /obj/item/clothing/under/rank/captain/dress))
					var/prev = M.name
					M.icon_state = "captain-dress-blue"
					M.item_state = "captain-dress-blue"
					M.name = "commander's uniform"
					M.real_name = "commander's uniform"
					M.desc = "A uniform specifically for NanoTrasen commanders. (Base Item: [prev])"
					H.set_clothing_icon_dirty()

				else if (istype(M, /obj/item/clothing/under/rank/captain))
					var/prev = M.name
					M.name = "commander's uniform"
					M.desc = "A uniform specifically for NanoTrasen commanders. (Base Item: [prev])"
					if (istype(M, /obj/item/clothing/under/rank/captain/fancy))
						M.icon_state = "captain-fancy-blue"
						M.item_state = "captain-fancy-blue"
					else if (istype(M, /obj/item/clothing/under/rank/captain/dress))
						M.icon_state = "captain-dress-blue"
						M.item_state = "captain-dress-blue"
					else
						M.icon_state = "captain-blue"
						M.item_state = "captain-blue"
					H.set_clothing_icon_dirty()

				else if (istype(M, /obj/item/clothing/under/suit/captain))
					var/prev = M.name
					M.name = "commander's uniform"
					M.desc = "A uniform specifically for NanoTrasen commanders. (Base Item: [prev])"
					M.icon_state = "suit-capB"
					M.item_state = "suit-capB"
					H.set_clothing_icon_dirty()

			if (H.wear_suit)
				var/obj/item/clothing/M = H.wear_suit
				if (istype(M, /obj/item/clothing/suit/armor/captain))
					var/prev = M.name
					M.icon_state = "centcom"
					M.item_state = "centcom"
					M.name = "commander's armor"
					M.real_name = "commander's armor"
					M.desc = "A suit of protective formal armor. It is made specifically for NanoTrasen commanders. (Base Item: [prev])"
					H.set_clothing_icon_dirty()

				else if (istype(M, /obj/item/clothing/suit/space/captain))
					var/prev = M.name
					M.icon_state = "spacecap-blue"
					M.item_state = "spacecap-blue"
					M.name = "commander's space suit"
					M.real_name = "commander's space suit"
					M.desc = "A suit that protects against low pressure environments. It is made specifically for NanoTrasen commanders. (Base Item: [prev])"
					H.set_clothing_icon_dirty()

			if (H.head)
				var/obj/item/clothing/M = H.head
				if (istype(M, /obj/item/clothing/head/caphat))
					var/prev = M.name
					M.icon_state = "centcom"
					M.item_state = "centcom"
					M.name = "commander's hat"
					M.real_name = "commander's hat"
					M.desc = "A fancy hat specifically for NanoTrasen commanders. (Base Item: [prev])"
					H.set_clothing_icon_dirty()
			if (H.belt)
				var/obj/item/M = H.belt
				if (istype(M, /obj/item/katana_sheath/captain))
					if (M.item_state == "scabbard-cap1")
						qdel(M)
						H.equip_if_possible(new /obj/item/katana_sheath/captain/blue(H), H.slot_belt)
		return

// I don't like this being tied to Nero
// but please use it for a different medal!!!!!
/*
/datum/achievementReward/centcom_administrator
	title = "(Skin Set) CENTCOM Administrator Uniform"
	desc = "Will change the skin of captain hats, captain armor/spacesuits and captain uniforms."
	required_medal = "Nero" //nero for now, only a suggestion, please replace if anyone has better ideas for this ty <3
	once_per_round = 0

	rewardActivate(var/mob/activator)
		if (ishuman(activator))
			var/mob/living/carbon/human/H = activator

			if (H.w_uniform)
				var/obj/item/clothing/M = H.w_uniform
				if (istype(M, /obj/item/clothing/under/rank/captain))
					var/prev = M.name
					M.name = "administrator's uniform"
					M.desc = "A uniform specifically for CENTCOM administrators. (Base Item: [prev])"
					if (istype(M, /obj/item/clothing/under/rank/captain/dress))
						M.icon_state = "captain-dress-red"
						M.item_state = "captain-dress-red"
					else
						M.icon_state = "captain-red"
						M.item_state = "captain-red"
					H.set_clothing_icon_dirty()

				else if (istype(M, /obj/item/clothing/under/suit/captain))
					var/prev = M.name
					M.name = "administrator's uniform"
					M.desc = "A uniform specifically for CENTCOM administrators. (Base Item: [prev])"
					M.icon_state = "suit-capR"
					M.item_state = "suit-capR"
					H.set_clothing_icon_dirty()

			if (H.wear_suit)
				var/obj/item/clothing/M = H.wear_suit
				if (istype(M, /obj/item/clothing/suit/armor/captain))
					var/prev = M.name
					M.icon_state = "centcom-red"
					M.item_state = "centcom-red"
					M.name = "administrator's armor"
					M.desc = "A suit of protective formal armor. It is made specifically for CENTCOM administrators. (Base Item: [prev])"
					H.set_clothing_icon_dirty()

				else if (istype(M, /obj/item/clothing/suit/space/captain))
					var/prev = M.name
					M.icon_state = "spacecap-red"
					M.item_state = "spacecap-red"
					M.name = "administrator's space suit"
					M.desc = "A suit that protects against low pressure environments. It is made specifically for CENTCOM administrators. (Base Item: [prev])"
					H.set_clothing_icon_dirty()

			if (H.head)
				var/obj/item/clothing/M = H.head
				if (istype(M, /obj/item/clothing/head/caphat))
					var/prev = M.name
					M.icon_state = "centcom-red"
					M.item_state = "centcom-red"
					M.name = "CENTCOM hat"
					M.desc = "A fancy hat specifically for CENTCOM administrators. (Base Item: [prev])"
					H.set_clothing_icon_dirty()
		return
*/

/datum/achievementReward/ai_malf
	title = "(AI Skin) Malfuction"
	desc = "Turns you into a scary malfunctioning AI! Only in appearance, of course."
	required_medal = "HUMANOID MUST NOT ESCAPE"

	rewardActivate(var/mob/activator)
		if (isAI(activator))
			var/mob/living/silicon/ai/A = activator
			A.custom_emotions = ai_emotions | list("ROGUE(reward)" = "ai-red")
			A.faceEmotion = "ai-red"
			A.set_color("#EE0000")
			//A.icon_state = "ai-malf"
		else
			boutput(activator, "<span style=\"color:red\">You need to be an AI to use this, you goof!</span>")
		return

/datum/achievementReward/borg_automoton
	title = "(Cyborg Skin) Automaton"
	desc = "Turns you into the mysterious Automaton! Only in appearance, of course. Keys not included."
	required_medal = "Icarus"

	rewardActivate(var/mob/activator)
		if (isrobot(activator))
			var/mob/living/silicon/robot/C = activator
			C.automaton_skin = 1
			C.update_appearance()
		else
			boutput(activator, "<span style=\"color:red\">You need to be a cyborg to use this, you goof!</span>")
		return
/*
/datum/achievementReward/secbelt
	title = "(Skin) Security Toolbelt"
	desc = "Turns your worn Utility Belt into a Security Toolbelt."
	required_medal = "Suitable? How about the Oubliette?!"

	rewardActivate(var/mob/living/carbon/human/activator)

	rewardActivate(var/mob/activator)
		if (!ishuman(activator))
			return

		var/mob/living/carbon/human/H = activator

		if (H.belt && istype(H.belt, /obj/item/storage/belt/utility))
			var/obj/item/storage/belt/utility/M = H.belt
			var/prev = M.name
			M.icon_state = "secbelt"
			M.item_state = "secbelt"
			M.name = "security toolbelt"
			M.real_name = "security toolbelt"
			M.desc = "For the trend-setting Security Officer on the go. (Base Item: [prev])"
			H.set_clothing_icon_dirty()
		return
*/

/datum/achievementReward/goldenGun
	title = "Golden Gun"
	desc = "Gold plates a shotgun, hunting rifle, detective revolver, or AK-47 you're holding."
	required_medal = "Helios"

	rewardActivate(var/mob/activator){
		if (ishuman(activator)){
			var/mob/living/carbon/human/H = activator
			var/obj/item/gun/kinetic/gunmod
			if (H.l_hand && H.l_hand.type in list(/obj/item/gun/kinetic/detectiverevolver, /obj/item/gun/kinetic/riotgun, /obj/item/gun/kinetic/ak47, /obj/item/gun/kinetic/hunting_rifle))
				gunmod = H.l_hand
			else if (H.r_hand && H.r_hand.type in list(/obj/item/gun/kinetic/detectiverevolver, /obj/item/gun/kinetic/riotgun, /obj/item/gun/kinetic/ak47, /obj/item/gun/kinetic/hunting_rifle))
				gunmod = H.r_hand
			if (!gunmod) return
			gunmod.name = "Golden [gunmod.name]"
			gunmod.icon_state = "golden_[gunmod.icon_state]"
		}
	}

/datum/achievementReward/smug
	title = "(Emote) Smug"
	desc = "Gives you the ability to be all smug about something. I bet nobody likes you."
	required_medal = ":10bux:"

	rewardActivate(var/mob/activator)
		if (!istype(activator))
			return
		activator.verbs += /proc/smugproc
		return

/datum/achievementReward/shelterbee
	title = "(Emote) Shelterbee"
	desc = "Shelterbee expresses what you cannot. And it's also pretty dang cute."
	required_medal = "Too Cool"

	rewardActivate(var/mob/activator)
		if (!istype(activator))
			return
		boutput(usr, "<span style=\"color:blue\">:shelterbee:</span>")
		animate_emote(usr, /obj/effect/shelterbee)
		return

/obj/effect/shelterbee
	name = "shelterbee"
	icon = 'icons/mob/64.dmi'
	icon_state = "shelterbee"
	anchored = 1.0
	pixel_x = -16
	pixel_y = -16

/datum/achievementReward/participantribbon
	title = "(Transformation) Participation Ribbon"
	desc = "Turn into a living participation ribbon. No refunds!"
	required_medal = "Fun Times"
	mobonly = 0

	rewardActivate(var/mob/activator)
		if (!isobserver(activator))
			boutput(activator, "<span style=\"color:red\">You gotta be dead to use this, you goof!</span>")
			return
		var/datum/effects/system/harmless_smoke_spread/smoke = new /datum/effects/system/harmless_smoke_spread()
		smoke.set_up(5, 0, get_turf(usr))
		smoke.attach(usr)
		smoke.start()
		var/mob/living/object/O = new /mob/living/object(new /obj/item/sticker/ribbon/participant(get_turf(usr)), usr)
		O.say_language = "animal"
		O.literate = 0
		return

/datum/achievementReward/goldbud
	title = "(Skin) Golden PR-4 Guardbuddy Frame"
	desc = "Gold plates a held PR-4 Guardbuddy frame."
	required_medal = "Ol' buddy ol' pal"
	once_per_round = 1

	rewardActivate(var/mob/activator)
		if (!istype(activator))
			return

		if (istype(activator.l_hand, /obj/item/guardbot_frame/old))
			var/obj/item/guardbot_frame/old/M = activator.l_hand
			new /obj/item/guardbot_frame/old/golden(get_turf(activator))
			qdel(M)

		else if (istype(activator.r_hand, /obj/item/guardbot_frame/old))
			var/obj/item/reagent_containers/glass/beaker/large/M = activator.r_hand
			new /obj/item/guardbot_frame/old/golden(get_turf(activator))
			qdel(M)

		else
			boutput(activator, "<span style=\"color:red\">You need to be holding a PR-4 Guardbuddy frame in order to claim this reward!</span>")
			return

		return


/proc/smugproc()
	set name = ":smug:"
	set desc = "Allows you to show others how great you feel about yourself for having paid 10 bucks."
	set category = "Commands"

	animate_emote(usr, /obj/effect/smug)
	usr.verbs -= /proc/smugproc
	usr.verbs += /proc/smugprocCD
	SPAWN_DBG(30 SECONDS)
		boutput(usr, "<span style=\"color:blue\">You can now be smug again! Go hog wild.</span>")
		usr.verbs += /proc/smugproc
		usr.verbs -= /proc/smugprocCD
	return

/proc/smugprocCD()
	set name = ":smug:"
	set desc = "Currently on cooldown."
	set category = "Commands"

	boutput(usr, "<span style=\"color:red\">You can't use that again just yet.</span>")
	return

/obj/effect/smug
	name = "smug"
	icon = 'icons/mob/64.dmi'
	icon_state = "smug"
	anchored = 1.0
	pixel_x = -16
	pixel_y = -16

/datum/achievementReward/beefriend
	title = "(Reagent) Bee"
	desc = "You're gonna burp one up, probably."
	required_medal = "Bombini is missing!"

	rewardActivate(var/mob/activator)
		if (!activator.reagents) return
		activator.reagents.add_reagent("bee", 5)
		boutput (activator, "<span style='color:red'>Pleeze hold, bee will bee with thee shortlee!</span>" )


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Management stuff below.
/chui/window/contributorrewards
	name = "Contributor Rewards"

	New()
		..()

	var/rewardses = list("sillyscream" = "Silly Screams")

	GetBody()
		var/ret = "<b>Howdy, contributor! These rewards don't revert until you respawn somehow.</b><br/>"
		for(var/choice in rewardses)
			ret += "[theme.generateButton( choice, rewardses[choice] )]<br/>"
		return ret

	OnClick( var/client/who, var/id )
		if( rewardses[id] )
			if(call( src, id )(who))
				Unsubscribe( src )
		else
			boutput( who, "<h1>Don't get ahead of yourself, [who.key]</h1>" )//I almost want to log who does this because I know Erik will be one of them

	proc/sillyscream(var/client/c)
		var/mob/living/living = c.mob
		if(istype( living ))
			living.sound_scream = pick('sound/voice/screams/sillyscream1.ogg','sound/voice/screams/sillyscream2.ogg')
			c << sound( living.sound_scream )
			return 1
		else
			boutput( usr, "<span style='color:red'>Hmm.. I can't set the scream sound of that!</span>" )
			return 0

/datum/achievementReward/contributor
	title = "Contributor Rewards"
	desc = "A whole host of things and buttons to reward you for contributing!"
	required_medal = "Contributor"
	once_per_round = 0
	mobonly = 0

	var/chui/window/contributorrewards/contributorRewardMenu
	New()
		..()

	rewardActivate(var/mob/activator)
		if( !contributorRewardMenu )
			contributorRewardMenu = new
		contributorRewardMenu.Subscribe( activator.client )
//You could even make one-time reward by stripping their medal here.

/client/var/list/claimed_rewards = list() //Keeps track of once-per-round rewards

/client/verb/claimreward()
	set background = 1
	set name = "Claim Reward"
	set desc = "Allows you to claim a Reward you might have earned."
	set category = "Commands"
	set popup_menu = 0

	SPAWN_DBG(0)
		src.verbs -= /client/verb/claimreward
		boutput(usr, "<span style=\"color:red\">Checking your eligibility. There might be a short delay, please wait.</span>")
		var/list/eligible = list()
		for(var/A in rewardDB)
			var/datum/achievementReward/D = rewardDB[A]
			var/result = usr.has_medal(D.required_medal)
			if(result == 1)
				if((D.once_per_round && !src.claimed_rewards.Find(D.type)) || !D.once_per_round)
					if( D.mobonly && !istype( src.mob, /mob/living ) ) continue
					eligible.Add(D.title)
					eligible[D.title] = D

		if(!length(eligible))
			boutput(usr, "<span style=\"color:red\">Sorry, you don't have any rewards available.</span>")
			src.verbs += /client/verb/claimreward
			return

		var/selection = input(usr,"Please select your reward", "VIP Rewards","CANCEL") in (eligible + "CANCEL")

		if(selection == "CANCEL")
			src.verbs += /client/verb/claimreward
			return

		var/datum/achievementReward/S = null

		for(var/X in rewardDB)
			var/datum/achievementReward/C = rewardDB[X]
			if(C.title == selection)
				S = C
				break

		if(S == null)
			boutput(usr, "<span style=\"color:red\">Invalid Rewardtype after selection. Please inform a coder.</span>")

		var/M = alert(usr,S.desc + "\n(Earned through the \"[S.required_medal]\" Medal)","Claim this Reward?","Yes","No")
		if(M == "Yes")
			S.rewardActivate(usr)
			if(S.once_per_round)
				usr.client.claimed_rewards.Add(S.type)
			src.verbs += /client/verb/claimreward
		else
			src.verbs += /client/verb/claimreward
