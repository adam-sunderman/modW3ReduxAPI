function W3ReduxCastSign(sign : ESignType) : bool
{
	//declare vars
	var signSkill : ESkill;

	//convert sign enumeration into actual Witcher Player skill
	signSkill = SignEnumToSkillEnum( sign );
	
	//validate skill is not undefined defined
	if( signSkill == S_SUndefined )
	{
		//Uh oh
		return false;
	}

	//immediately equip the desired sign
	GetWitcherPlayer().SetEquippedSign(sign);
	
	//can cast validation
	if( !thePlayer.IsActionAllowed(EIAB_Signs) )
	{
		thePlayer.DisplayActionDisallowedHudMessage(EIAB_Signs);
		return false;
	}
	if ( thePlayer.IsHoldingItemInLHand() && thePlayer.IsUsableItemLBlocked() )
	{
		thePlayer.DisplayActionDisallowedHudMessage(EIAB_Undefined, false, false, true);
		return false;
	}
	
	//skill validation
	if(!thePlayer.CanUseSkill(signSkill))
	{
		thePlayer.DisplayActionDisallowedHudMessage(EIAB_Signs, false, false, true);
		return false;
	}
	if(!thePlayer.HasStaminaToUseSkill( signSkill, false ) )
	{
		thePlayer.SoundEvent("gui_no_stamina");
		return false;
	}

	//Validated. Cast Sign!
	thePlayer.SetupCombatAction( EBAT_CastSign, BS_Pressed );
	return true;
}