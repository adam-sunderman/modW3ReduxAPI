/***********************************************************************/
/** 	© 2015 CD PROJEKT S.A. All rights reserved.
/** 	THE WITCHER® is a trademark of CD PROJEKT S. A.
/** 	The Witcher game is based on the prose of Andrzej Sapkowski.
/***********************************************************************/

class CW3ReduxInput extends CPlayerInput
{
	private var modGamepad 		: CW3ReduxGamepad;
	private var log 			: CW3ReduxLogger;
		
	public function Initialize(isFromLoad : bool, optional previousInput : CPlayerInput)
	{
		//variable to cast previous input to our derived class
		var previousInputAsRedux : CW3ReduxInput;
	
		//initialize logger
		log = new CW3ReduxLogger in this;
		log.init('W3ReduxAPI', 'Input', EW3ReduxLogDebug);
		
		//if previous input was provided, we should use previous gamepad. no reason to re-initialize the gamepad
		if(!previousInput)
		{
			modGamepad = new CW3ReduxGamepad in this;
			modGamepad.initialize();
			log.info("new input and new gamepad initialized");
		}
		else
		{
			previousInputAsRedux = (CW3ReduxInput) previousInput;
			modGamepad = previousInputAsRedux.modGamepad;
			log.info("input re-created. re-using singleton gamepad");
		}
		
		//allow CPlayerInput to initialize. This is important because unless a button is mapped,
		//we will still let CPlayerInput handle an input action same as Vanilla
		super.Initialize(isFromLoad, previousInput);
		
		//register listeners for ALL gamepad buttons and their respective "hold" actions
		theInput.RegisterListener(this, 'OnW3ReduxAPIA', 'W3ReduxAPI_A');
		theInput.RegisterListener(this, 'OnW3ReduxAPIAHold', 'W3ReduxAPI_AHold');
		theInput.RegisterListener(this, 'OnW3ReduxAPIB', 'W3ReduxAPI_B');
		theInput.RegisterListener(this, 'OnW3ReduxAPIBHold', 'W3ReduxAPI_BHold');
		theInput.RegisterListener(this, 'OnW3ReduxAPIX', 'W3ReduxAPI_X');
		theInput.RegisterListener(this, 'OnW3ReduxAPIXHold', 'W3ReduxAPI_XHold');
		theInput.RegisterListener(this, 'OnW3ReduxAPIY', 'W3ReduxAPI_Y');
		theInput.RegisterListener(this, 'OnW3ReduxAPIYHold', 'W3ReduxAPI_YHold');
	}
	
	function getGamepad() : IW3ReduxGamepad
	{
		log.debug("getGamepad(): gave instance of gamepad API to caller");
		return modGamepad;
	}
	
	public function step()
	{
		var newInputState : EW3ReduxInputState;
		
		if(contextNameToW3ReduxInputState(theInput.GetContext(), newInputState))
		{
			modGamepad.setInputState(newInputState);
		}
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////////
	/*************************START INPUT ACTION EVENTS******************************************/
	//////////////////////////////////////////////////////////////////////////////////////////////
	event OnW3ReduxAPIA(action : SInputAction)
	{
		return modGamepad.acceptAction(EW3ReduxGamepadA, action);
	}
	
	event OnW3ReduxAPIAHold(action: SInputAction)
	{
		return modGamepad.acceptActionHold(EW3ReduxGamepadA, action);
	}
	
	event OnW3ReduxAPIB(action : SInputAction)
	{
		return modGamepad.acceptAction(EW3ReduxGamepadB, action);
	}
	
	event OnW3ReduxAPIBHold(action: SInputAction)
	{
		return modGamepad.acceptActionHold(EW3ReduxGamepadB, action);
	}
	
	event OnW3ReduxAPIX(action : SInputAction)
	{
		return modGamepad.acceptAction(EW3ReduxGamepadX, action);
	}
	
	event OnW3ReduxAPIXHold(action: SInputAction)
	{
		return modGamepad.acceptActionHold(EW3ReduxGamepadX, action);
	}
	
	event OnW3ReduxAPIY(action : SInputAction)
	{
		return modGamepad.acceptAction(EW3ReduxGamepadY, action);
	}
	
	event OnW3ReduxAPIYHold(action: SInputAction)
	{
		return modGamepad.acceptActionHold(EW3ReduxGamepadY, action);
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////////
	/*************************START VANILLA INPUT ACTION OVERRIDES*******************************/
	/*************************NOTE:	we just override controller inputs***************************/
	//////////////////////////////////////////////////////////////////////////////////////////////
	event OnCommSprint( action : SInputAction )
	{
		var button : EW3ReduxGamepadButton;
		var mapAction : SW3ReduxMapAction;
		
		if(!actionToEW3ReduxGamepadButton(action, button))
		{
			log.error("OnCommSprint(): received SInputAction that was not able to be mapped to a button");
			return false;
		}
		
		mapAction.button = button;
		mapAction.action = EW3ReduxGamepadButtonHold;
		
		if(modGamepad.hasOwnerInCurrentState(mapAction))
		{
			return false;
		}
		
		return super.OnCommSprint(action);
	}
	
		
	event OnCommGuard( action : SInputAction )
	{
		var button : EW3ReduxGamepadButton;
		var mapAction : SW3ReduxMapAction;
		
		if(!actionToEW3ReduxGamepadButton(action, button))
		{
			log.error("OnCommGuard(): received SInputAction that was not able to be mapped to a button");
			return false;
		}
		mapAction.button = button;
		mapAction.action = EW3ReduxGamepadButtonHold;
		
		if(modGamepad.hasOwnerInCurrentState(mapAction))
		{
			return false;
		}
		
		return super.OnCommGuard(action);
	}	

	event OnCommSpawnHorse( action : SInputAction )
	{
		var button : EW3ReduxGamepadButton;
		
		if(!actionToEW3ReduxGamepadButton(action, button))
		{
			log.error("OnCommSpawnHorse(): received SInputAction that was not able to be mapped to a button");
			return false;
		}
		
		//if(currentInputSet.hasDoubleTapOwner(button))
		//{
		//	return false;
		//}
		
		return super.OnCommSpawnHorse(action);
	}

	event OnCommMenuHub( action : SInputAction )
	{
		var button : EW3ReduxGamepadButton;
		
		//if(!actionToEW3ReduxGamepadButton(action, button))
		//{
		//	return false;
		//}
		//
		//if(currentInputSet.hasTapOwner(button))
		//{
		//	return false;
		//}
		
		return super.OnCommMenuHub(action);
	}

	event OnCommSteelSword( action : SInputAction )
	{
		return super.OnCommSteelSword(action);
	}
	
	event OnCommSilverSword( action : SInputAction )
	{
		return super.OnCommSilverSword(action);
	}	
	
	event OnCommSheatheAny( action : SInputAction )
	{
		return super.OnCommSheatheAny(action);	
	}
	
	event OnCommSheatheSteel( action : SInputAction )
	{
		return super.OnCommSheatheSteel(action);
	}
	
	event OnCommSheatheSilver( action : SInputAction )
	{
		return super.OnCommSheatheSilver(action);
	}
		
	event OnCommDrinkPot( action : SInputAction )
	{
		return super.OnCommDrinkPot(action);
	}
	
	event OnCbtComboDigitLeft( action : SInputAction )
	{
		return super.OnCbtComboDigitLeft(action);
	}
	
	event OnCbtComboDigitRight( action : SInputAction )
	{
		return super.OnCbtComboDigitRight(action);
	}
	
	event OnSelectSign(action : SInputAction)
	{
		return super.OnSelectSign(action);
	}
	
	event OnToggleSigns( action : SInputAction )
	{
		return super.OnToggleSigns(action);
	}
	event OnToggleNextSign( action : SInputAction )
	{
		return super.OnToggleNextSign(action);
	}
	event OnTogglePreviousSign( action : SInputAction )
	{
		return super.OnTogglePreviousSign(action);
	}
	
	event OnToggleItem( action : SInputAction )
	{
		return super.OnToggleItem(action);
	}

	event OnCommDrinkpotionUpperHeld( action : SInputAction )
	{
		return super.OnCommDrinkpotionUpperHeld(action);
	}
	
	event OnCommDrinkpotionLowerHeld( action : SInputAction )
	{
		return super.OnCommDrinkpotionLowerHeld(action);
	}
	
	event OnCommDrinkPotion1( action : SInputAction )
	{
		return super.OnCommDrinkPotion1(action);
	}
	
	
	event OnCommDrinkPotion2( action : SInputAction )
	{
		return super.OnCommDrinkPotion2(action);
	}
	
	event OnCommDrinkPotion3( action : SInputAction )
	{
		return super.OnCommDrinkPotion3(action);
	}
	
	
	event OnCommDrinkPotion4( action : SInputAction )
	{
		return super.OnCommDrinkPotion4(action);
	}
	
	event OnDiving( action : SInputAction )
	{
		return super.OnDiving(action);
	}
	
	event OnDivingDodge( action : SInputAction )
	{
		return super.OnDivingDodge(action);
	}

	event OnExpFistFightLight( action : SInputAction )
	{
		return super.OnExpFistFightLight(action);
	}
	
	event OnExpFistFightHeavy( action : SInputAction )
	{
		return super.OnExpFistFightHeavy(action);
	}
	
	event OnExpFocus( action : SInputAction )
	{
		return super.OnExpFocus(action);
	}
	
	event OnCbtAttackWithAlternateLight( action : SInputAction )
	{
		return super.OnCbtAttackWithAlternateLight(action);
	}
	
	event OnCbtAttackWithAlternateHeavy( action : SInputAction )
	{
		return super.OnCbtAttackWithAlternateHeavy(action);
	}
	
	event OnCbtAttackLight( action : SInputAction )
	{
		var button : EW3ReduxGamepadButton;
		var mapAction : SW3ReduxMapAction;
		
		if(!actionToEW3ReduxGamepadButton(action, button))
		{
			return false;
		}
		mapAction.button = button;
		mapAction.action = EW3ReduxGamepadButtonTap;
		
		if(modGamepad.hasOwnerInCurrentState(mapAction))
		{
			return false;
		}
	
		return super.OnCbtAttackLight(action);
	}
	
	event OnCbtAttackHeavy( action : SInputAction )
	{
		var button : EW3ReduxGamepadButton;
		var mapAction : SW3ReduxMapAction;
		
		if(!actionToEW3ReduxGamepadButton(action, button))
		{
			return false;
		}
		mapAction.button = button;
		mapAction.action = EW3ReduxGamepadButtonTap;	

		if(modGamepad.hasOwnerInCurrentState(mapAction))
		{
			return false;
		}
		
		return super.OnCbtAttackHeavy(action);
	}
	
	event OnCbtSpecialAttackWithAlternateLight( action : SInputAction )
	{
		return super.OnCbtSpecialAttackWithAlternateLight(action);
	}
	
	event OnCbtSpecialAttackWithAlternateHeavy( action : SInputAction )
	{
		return super.OnCbtSpecialAttackWithAlternateHeavy(action);
	}
	
	event OnCbtSpecialAttackLight( action : SInputAction )
	{
		return super.OnCbtSpecialAttackLight(action);
	}	

	event OnCbtSpecialAttackHeavy( action : SInputAction )
	{
		return super.OnCbtSpecialAttackHeavy(action);
	}
	
	event OnCbtCiriSpecialAttack( action : SInputAction )
	{
		return super.OnCbtCiriSpecialAttack(action);
	}
	
	event OnCbtCiriAttackHeavy( action : SInputAction )
	{
		return super.OnCbtCiriAttackHeavy(action);
	}
	
	event OnCbtCiriSpecialAttackHeavy( action : SInputAction )
	{	
		return super.OnCbtCiriSpecialAttackHeavy(action);
	}
	
	event OnCbtCiriDodge( action : SInputAction )
	{	
		if( IsActionAllowed(EIAB_Dodge) && IsPressed(action) && thePlayer.IsAlive() )	
		{
			if ( thePlayer.IsInCombatAction() && thePlayer.GetCombatAction() == EBAT_Ciri_SpecialAttack && thePlayer.GetBehaviorVariable( 'isCompletingSpecialAttack' ) <= 0 )
			{
				thePlayer.PushCombatActionOnBuffer( EBAT_Ciri_Dodge, BS_Pressed );
				thePlayer.ProcessCombatActionBuffer();			
			}
			else if ( thePlayer.GetBIsInputAllowed() )
			{
				thePlayer.PushCombatActionOnBuffer( EBAT_Ciri_Dodge, BS_Pressed );
				if ( thePlayer.GetBIsCombatActionAllowed() )
					thePlayer.ProcessCombatActionBuffer();
			}
			else
			{
				if ( thePlayer.IsInCombatAction() && thePlayer.GetBehaviorVariable( 'combatActionType' ) == (int)CAT_Attack )
				{
					if ( thePlayer.CanPlayHitAnim() && thePlayer.IsThreatened() )
					{
						thePlayer.CriticalEffectAnimationInterrupted("CiriDodge");
						thePlayer.PushCombatActionOnBuffer( EBAT_Ciri_Dodge, BS_Pressed );
						thePlayer.ProcessCombatActionBuffer();							
					}
					else
						thePlayer.PushCombatActionOnBuffer( EBAT_Ciri_Dodge, BS_Pressed );
				}
			}
		}
		else if ( !IsActionAllowed(EIAB_Dodge) )
		{
			thePlayer.DisplayActionDisallowedHudMessage(EIAB_Dodge);
		}
	}
	
	event OnCbtCiriDash( action : SInputAction )
	{
		if ( theInput.LastUsedGamepad() && IsPressed( action ) )
		{
			thePlayer.StartDodgeTimer();
		}
		else if( IsActionAllowed(EIAB_Dodge) && thePlayer.IsAlive() )	
		{
			if ( theInput.LastUsedGamepad() )
			{
				if ( !(thePlayer.IsDodgeTimerRunning() && !thePlayer.IsInsideInteraction() && IsReleased(action)) )
					return false;
			}
			
			if ( thePlayer.IsInCombatAction() && thePlayer.GetCombatAction() == EBAT_Ciri_SpecialAttack && thePlayer.GetBehaviorVariable( 'isCompletingSpecialAttack' ) <= 0 )
			{
				thePlayer.PushCombatActionOnBuffer( EBAT_Roll, BS_Released );
				thePlayer.ProcessCombatActionBuffer();			
			}
			else if ( thePlayer.GetBIsInputAllowed() )
			{
				thePlayer.PushCombatActionOnBuffer( EBAT_Roll, BS_Released );
				if ( thePlayer.GetBIsCombatActionAllowed() )
					thePlayer.ProcessCombatActionBuffer();
			}
			else
			{
				if ( thePlayer.IsInCombatAction() && thePlayer.GetBehaviorVariable( 'combatActionType' ) == (int)CAT_Attack )
				{
					if ( thePlayer.CanPlayHitAnim() && thePlayer.IsThreatened() )
					{
						thePlayer.CriticalEffectAnimationInterrupted("CiriDodge");
						thePlayer.PushCombatActionOnBuffer( EBAT_Roll, BS_Released );
						thePlayer.ProcessCombatActionBuffer();							
					}
					else
						thePlayer.PushCombatActionOnBuffer( EBAT_Roll, BS_Released );
				}
			}
		}
		else if ( !IsActionAllowed(EIAB_Dodge) )
		{
			thePlayer.DisplayActionDisallowedHudMessage(EIAB_Dodge);
		}
	}
	
	event OnCbtDodge( action : SInputAction )
	{
		if ( IsPressed(action) )
			thePlayer.EvadePressed(EBAT_Dodge);
	}
	
	event OnCbtRoll( action : SInputAction )
	{
		if ( theInput.LastUsedPCInput() )
		{
			if ( IsPressed( action ) )
			{
				thePlayer.EvadePressed(EBAT_Roll);
			}
		}
		else
		{
			if ( IsPressed( action ) )
			{
				thePlayer.StartDodgeTimer();
			}
			else if ( IsReleased( action ) )
			{
				if ( thePlayer.IsDodgeTimerRunning() )
				{
					thePlayer.StopDodgeTimer();
					if ( !thePlayer.IsInsideInteraction() )
						thePlayer.EvadePressed(EBAT_Roll);
				}
				
			}
		}
	}
	
	event OnMovementDoubleTap( action : SInputAction )
	{
		if ( IsPressed( action ) )
		{
			if ( !thePlayer.IsDodgeTimerRunning() || action.aName != lastMovementDoubleTapName )
			{
				thePlayer.StartDodgeTimer();
				lastMovementDoubleTapName = action.aName;
			}
			else
			{
				thePlayer.StopDodgeTimer();
				
				thePlayer.EvadePressed(EBAT_Dodge);
			}
			
		}
	}
	
	event OnCastSign( action : SInputAction )
	{
		var signSkill : ESkill;
	
		if( !thePlayer.GetBIsInputAllowed() )
		{	
			return false;
		}
		
		if( IsPressed(action) )
		{
			if( !IsActionAllowed(EIAB_Signs) )
			{				
				thePlayer.DisplayActionDisallowedHudMessage(EIAB_Signs);
				return false;
			}
 if ( thePlayer.IsHoldingItemInLHand() && thePlayer.IsUsableItemLBlocked() )
			{
				thePlayer.DisplayActionDisallowedHudMessage(EIAB_Undefined, false, false, true);
				return false;
			}
			signSkill = SignEnumToSkillEnum( thePlayer.GetEquippedSign() );
			if( signSkill != S_SUndefined )
			{
				if(!thePlayer.CanUseSkill(signSkill))
				{
					thePlayer.DisplayActionDisallowedHudMessage(EIAB_Signs, false, false, true);
					return false;
				}
			
				if( thePlayer.HasStaminaToUseSkill( signSkill, false ) )
				{
					if( GetInvalidUniqueId() != thePlayer.inv.GetItemFromSlot( 'l_weapon' ) && !thePlayer.IsUsableItemLBlocked())
					{

						
						
					}
					
					thePlayer.SetupCombatAction( EBAT_CastSign, BS_Pressed );
				}
				else
				{
					thePlayer.SoundEvent("gui_no_stamina");
				}
			}
		}
	}
	
	
	
	
	event OnThrowBomb(action : SInputAction)
	{
		var selectedItemId : SItemUniqueId;
	
		selectedItemId = thePlayer.GetSelectedItemId();
		if(!thePlayer.inv.IsItemBomb(selectedItemId))
			return false;
		
		if( thePlayer.inv.SingletonItemGetAmmo(selectedItemId) == 0 )
		{
			
			if(IsPressed(action))
			{			
				thePlayer.SoundEvent( "gui_ingame_low_stamina_warning" );
			}
			
			return false;
		}
		
		if ( IsReleased(action) )
		{
			if ( thePlayer.IsThrowHold() )
			{
				if ( thePlayer.playerAiming.GetAimedTarget() )
				{
					if ( thePlayer.AllowAttack( thePlayer.playerAiming.GetAimedTarget(), EBAT_ItemUse ) )
					{
						thePlayer.PushCombatActionOnBuffer( EBAT_ItemUse, BS_Released );
						thePlayer.ProcessCombatActionBuffer();
					}
					else
						thePlayer.BombThrowAbort();
				}
				else
				{
					thePlayer.PushCombatActionOnBuffer( EBAT_ItemUse, BS_Released );
					thePlayer.ProcessCombatActionBuffer();				
				}
				
				thePlayer.SetThrowHold( false );
	
				return true;
		
			}
			else
			{
				if(!IsActionAllowed(EIAB_ThrowBomb))
				{
					thePlayer.DisplayActionDisallowedHudMessage(EIAB_ThrowBomb);
					return false;
				}
				
				if ( thePlayer.IsHoldingItemInLHand() && !thePlayer.IsUsableItemLBlocked() )
				{
					thePlayer.SetPlayerActionToRestore ( PATR_ThrowBomb );
					thePlayer.OnUseSelectedItem( true );
					return true;
				}
				if(thePlayer.CanSetupCombatAction_Throw() && theInput.GetLastActivationTime( action.aName ) < 0.3f )	
				{
					
					thePlayer.SetupCombatAction( EBAT_ItemUse, BS_Pressed );
					return true;
				}		
			
				thePlayer.SetupCombatAction( EBAT_ItemUse, BS_Released );
				return true;
			}
		}
		
		return false;
	}
	
	event OnThrowBombHold(action : SInputAction)
	{
		var locks : array<SInputActionLock>;
		var ind : int;

		var selectedItemId : SItemUniqueId;
	
		selectedItemId = thePlayer.GetSelectedItemId();
		if(!thePlayer.inv.IsItemBomb(selectedItemId))
			return false;
		
		if( thePlayer.inv.SingletonItemGetAmmo(selectedItemId) == 0 )
		{
			
			if(IsPressed(action))
			{			
				thePlayer.SoundEvent( "gui_ingame_low_stamina_warning" );
			}
			
			return false;
		}
			
		if( IsPressed(action) )
		{
			if(!IsActionAllowed(EIAB_ThrowBomb))
			{
				thePlayer.DisplayActionDisallowedHudMessage(EIAB_ThrowBomb);
				return false;
			}
			else if(GetWitcherPlayer().GetBombDelay(GetWitcherPlayer().GetItemSlot(selectedItemId)) > 0 )
			{
				
				return false;
			}
			if ( thePlayer.IsHoldingItemInLHand() && !thePlayer.IsUsableItemLBlocked() )
			{
				thePlayer.SetPlayerActionToRestore ( PATR_ThrowBomb );
				thePlayer.OnUseSelectedItem( true );
				return true;
			}
			if(thePlayer.CanSetupCombatAction_Throw() && theInput.GetLastActivationTime( action.aName ) < 0.3f )	
			{
				if( thePlayer.GetBIsCombatActionAllowed() )
				{
					thePlayer.PushCombatActionOnBuffer( EBAT_ItemUse, BS_Pressed );
					thePlayer.ProcessCombatActionBuffer();
				}
			}		
		
			
			
			locks = GetActionLocks(EIAB_ThrowBomb);
			ind = FindActionLockIndex(EIAB_ThrowBomb, 'BombThrow');
			if(ind >= 0)
				locks.Erase(ind);
			
			if(locks.Size() != 0)
				return false;
			
			thePlayer.SetThrowHold( true );
			return true;
		}

		return false;
	}
	
	event OnThrowBombAbort(action : SInputAction)
	{		
		if( IsPressed(action) )
		{		
			thePlayer.BombThrowAbort();
		}
	}
	
	
	
	
	
	event OnCbtThrowItem( action : SInputAction )
	{			
		var isUsableItem, isCrossbow, isBomb, ret : bool;
		var itemId : SItemUniqueId;		
		
		
		if(thePlayer.IsInAir() || thePlayer.GetWeaponHolster().IsOnTheMiddleOfHolstering())
			return false;
			
		if( thePlayer.IsSwimming() && !thePlayer.OnCheckDiving() && thePlayer.GetCurrentStateName() != 'AimThrow' )
			return false;
				
		itemId = thePlayer.GetSelectedItemId();
		
		if(!thePlayer.inv.IsIdValid(itemId))
			return false;
		
		isCrossbow = thePlayer.inv.IsItemCrossbow(itemId);
		if(!isCrossbow)
		{
			isBomb = thePlayer.inv.IsItemBomb(itemId);
			if(!isBomb)
			{
				isUsableItem = true;
			}
		}
		
		
		
		
		if( isCrossbow )
		{
			if ( IsActionAllowed(EIAB_Crossbow) )
			{
				if( IsPressed(action))
				{
					if ( thePlayer.IsHoldingItemInLHand() && !thePlayer.IsUsableItemLBlocked() )
					{

						
						thePlayer.SetPlayerActionToRestore ( PATR_Crossbow );
						thePlayer.OnUseSelectedItem( true );
						ret = true;						
					}
					else if ( thePlayer.GetBIsInputAllowed() && !thePlayer.IsCurrentlyUsingItemL() )
					{
						thePlayer.SetIsAimingCrossbow( true );
						thePlayer.SetupCombatAction( EBAT_ItemUse, BS_Pressed );
						
						
						ret = true;
					}
				}
				else
				{

					if ( thePlayer.GetIsAimingCrossbow() && !thePlayer.IsCurrentlyUsingItemL() )
					{
						thePlayer.SetupCombatAction( EBAT_ItemUse, BS_Released );
						
						
						thePlayer.SetIsAimingCrossbow( false );
						ret = true;
					}
				}
			}
			else
			{
				if ( !thePlayer.IsInShallowWater() )
					thePlayer.DisplayActionDisallowedHudMessage(EIAB_Crossbow);				
			}
			
			if ( IsPressed(action) )
				thePlayer.AddTimer( 'IsItemUseInputHeld', 0.00001, true );
			else
				thePlayer.RemoveTimer('IsItemUseInputHeld');
				
			return ret;
		}
		else if(isBomb)
		{
			return OnThrowBomb(action);
		}
		else if(isUsableItem && !thePlayer.IsSwimming() )
		{
			if( IsActionAllowed(EIAB_UsableItem) )
			{
				if(IsPressed(action) && thePlayer.HasStaminaToUseAction(ESAT_UsableItem))
				{
					thePlayer.SetPlayerActionToRestore ( PATR_Default );
					thePlayer.OnUseSelectedItem();
					return true;
				}

			}
			else
			{
				thePlayer.DisplayActionDisallowedHudMessage(EIAB_UsableItem);
			}
		}
		
		return false;
	}
	
	event OnCbtThrowItemHold( action : SInputAction )
	{
		var isBomb, isCrossbow, isUsableItem : bool;
		var itemId : SItemUniqueId;
		
		
		if(thePlayer.IsInAir() || thePlayer.GetWeaponHolster().IsOnTheMiddleOfHolstering() )
			return false;
			
		if( thePlayer.IsSwimming() && !thePlayer.OnCheckDiving() && thePlayer.GetCurrentStateName() != 'AimThrow' )
			return false;			
				
		itemId = thePlayer.GetSelectedItemId();
		
		if(!thePlayer.inv.IsIdValid(itemId))
			return false;
		
		isCrossbow = thePlayer.inv.IsItemCrossbow(itemId);
		if(!isCrossbow)
		{
			isBomb = thePlayer.inv.IsItemBomb(itemId);
			if(isBomb)
			{
				return OnThrowBombHold(action);
			}
			else
			{
				isUsableItem = true;
			}
		}
		
		
		if(IsPressed(action))
		{
			if( isCrossbow && !IsActionAllowed(EIAB_Crossbow) )
			{
				thePlayer.DisplayActionDisallowedHudMessage(EIAB_Crossbow);
				return false;
			}
			
			if( isUsableItem)
			{
				if(!IsActionAllowed(EIAB_UsableItem))
				{
					thePlayer.DisplayActionDisallowedHudMessage(EIAB_UsableItem);
					return false;
				}
				else if(thePlayer.IsSwimming())
				{
					thePlayer.DisplayActionDisallowedHudMessage(EIAB_Undefined, false, false, true);
					return false;
				}
			}
		}
	
		if( IsPressed(action) )
		{
			thePlayer.SetThrowHold( true );
			return true;
		}
		else if( IsReleased(action) && thePlayer.IsThrowHold())
		{
			
			
			thePlayer.SetupCombatAction( EBAT_ItemUse, BS_Released );
			thePlayer.SetThrowHold( false );
			return true;
		}
		
		return false;
	}
	
	event OnCbtThrowCastAbort( action : SInputAction )
	{
		var player : W3PlayerWitcher;
		var throwStage : EThrowStage;
		
		if(thePlayer.inv.IsItemBomb(thePlayer.GetSelectedItemId()))
		{
			return OnThrowBombAbort(action);							
		}
		
		if( IsPressed(action) )
		{
			player = GetWitcherPlayer();
			if(player)
			{
				if( player.IsCastingSign() )
				{
					player.CastSignAbort();
				}
				else
				{
					if ( thePlayer.inv.IsItemCrossbow( thePlayer.inv.GetItemFromSlot( 'l_weapon' ) ) )
					{
						thePlayer.OnRangedForceHolster();
					}
					else
					{
						throwStage = (int)thePlayer.GetBehaviorVariable( 'throwStage', (int)TS_Stop);
						
						if(throwStage == TS_Start || throwStage == TS_Loop)
							player.ThrowingAbort();
					}
				}
			}
		}
	}
	
	event OnCbtSelectLockTarget( inputVector : Vector )
	{
		var newLockTarget 	: CActor;
		var inputHeading	: float;
		var target			: CActor;
		
		inputVector.Y = inputVector.Y  * -1.f;
		inputHeading =	VecHeading( inputVector );
		
		newLockTarget = thePlayer.GetScreenSpaceLockTarget( thePlayer.GetDisplayTarget(), 180.f, 1.f, inputHeading );

		if ( newLockTarget )
			thePlayer.ProcessLockTarget( newLockTarget );
		
		target = thePlayer.GetTarget();
		if ( target )
		{
			thePlayer.SetSlideTarget( target );
			
		}
	}

	event OnCbtLockAndGuard( action : SInputAction )
	{
		if(thePlayer.IsCiri() && !GetCiriPlayer().HasSword())
			return false;
		
		
		if( IsReleased(action) )
		{
			thePlayer.SetGuarded(false);
			thePlayer.OnGuardedReleased();	
		}
		
		if( (thePlayer.IsWeaponHeld('fists') || thePlayer.GetCurrentStateName() == 'CombatFists') && !IsActionAllowed(EIAB_Fists))
		{
			thePlayer.DisplayActionDisallowedHudMessage(EIAB_Fists);
			return false;
		}
		
		if( IsPressed(action) )
		{
			if( !IsActionAllowed(EIAB_Parry) )
			{
				if ( IsActionBlockedBy(EIAB_Parry,'UsableItem') )
				{
					thePlayer.DisplayActionDisallowedHudMessage(EIAB_Parry);
				}
				return true;
			}
				
			if ( thePlayer.GetCurrentStateName() == 'Exploration' )
				thePlayer.GoToCombatIfNeeded();
				
			if ( thePlayer.bLAxisReleased )
				thePlayer.ResetRawPlayerHeading();
			
			if ( thePlayer.rangedWeapon && thePlayer.rangedWeapon.GetCurrentStateName() != 'State_WeaponWait' )
				thePlayer.OnRangedForceHolster( true, true );
			
			thePlayer.AddCounterTimeStamp(theGame.GetEngineTime());	
			thePlayer.SetGuarded(true);				
			thePlayer.OnPerformGuard();
		}	
	}		
	
	event OnCbtCameraLockOrSpawnHorse( action : SInputAction )
	{
		if ( OnCbtCameraLock(action) )
			return true;
			
		if ( OnCommSpawnHorse(action) )
			return true;
			
		return false;
	}
	
	event OnCbtCameraLock( action : SInputAction )
	{	
		if( IsPressed(action) )
		{
			if ( thePlayer.IsThreatened() || thePlayer.IsActorLockedToTarget() )
			{
				if( !IsActionAllowed(EIAB_CameraLock))
				{
					return false;
				}
				else if ( !thePlayer.IsHardLockEnabled() && thePlayer.GetDisplayTarget() && (CActor)( thePlayer.GetDisplayTarget() ) && IsActionAllowed(EIAB_HardLock))
				{	
					if ( thePlayer.bLAxisReleased )
						thePlayer.ResetRawPlayerHeading();
					
					thePlayer.HardLockToTarget( true );
				}
				else
				{
					thePlayer.HardLockToTarget( false );
				}	
				return true;
			}
		}
		return false;
	}
	
	event OnChangeCameraPreset( action : SInputAction )
	{
		if( IsPressed(action) )
		{
			((CCustomCamera)theCamera.GetTopmostCameraObject()).NextPreset();
		}
	}
	
	event OnChangeCameraPresetByMouseWheel( action : SInputAction )
	{
		return super.OnChangeCameraPresetByMouseWheel(action);
	}
	
	event OnMeditationAbort(action : SInputAction)
	{
		var med : W3PlayerWitcherStateMeditation;
		
		if (!theGame.GetGuiManager().IsAnyMenu())
		{
			med = (W3PlayerWitcherStateMeditation)GetWitcherPlayer().GetCurrentState();
			if(med)
			{
				
				
				med.StopRequested(false);
			}
		}
	}

	event OnDbgSpeedUp( action : SInputAction )
	{
		if( theGame.IsFinalBuild() )
		{
			return false;
		}
		
		if(IsPressed(action))
		{
			theGame.SetTimeScale(4, theGame.GetTimescaleSource(ETS_DebugInput), theGame.GetTimescalePriority(ETS_DebugInput));
		}
		else if(IsReleased(action))
		{
			theGame.RemoveTimeScale( theGame.GetTimescaleSource(ETS_DebugInput) );
		}
	}
	
	event OnDbgHit( action : SInputAction )
	{
		if( theGame.IsFinalBuild() )
		{
			return false;
		}
		
		if(IsReleased(action))
		{
			thePlayer.SetBehaviorVariable( 'HitReactionDirection',(int)EHRD_Back);
			thePlayer.SetBehaviorVariable( 'isAttackReflected', 0 );
			thePlayer.SetBehaviorVariable( 'HitReactionType', (int)EHRT_Heavy);
			thePlayer.SetBehaviorVariable( 'HitReactionWeapon', 0);
			thePlayer.SetBehaviorVariable( 'HitSwingDirection',(int)ASD_LeftRight);
			thePlayer.SetBehaviorVariable( 'HitSwingType',(int)AST_Horizontal);
			
			thePlayer.RaiseForceEvent( 'Hit' );
			thePlayer.OnRangedForceHolster( true );
			GetWitcherPlayer().SetCustomRotation( 'Hit', thePlayer.GetHeading()+180, 1080.f, 0.1f, false );
			thePlayer.CriticalEffectAnimationInterrupted("OnDbgHit");
		}
	}
	
	event OnDbgKillTarget( action : SInputAction )
	{
		var target : CActor;
		
		if( theGame.IsFinalBuild() )
		{
			return false;
		}
		
		target = thePlayer.GetTarget();
		
		if( target && IsReleased(action) )
		{
			target.Kill( 'Debug' );
		}
	}
	
	event OnDbgKillAll( action : SInputAction )
	{
		if( theGame.IsFinalBuild() )
		{
			return false;
		}
		
		if(IsReleased(action))
			thePlayer.DebugKillAll();
	}
	
	
	event OnDbgKillAllTargetingPlayer( action : SInputAction )
	{
		var i : int;
		var all : array<CActor>;
	
		if( theGame.IsFinalBuild() )
		{
			return false;
		}
		
		if(IsPressed(action))
		{
			all = GetActorsInRange(thePlayer, 10000, 10000, '', true);
			for(i=0; i<all.Size(); i+=1)
			{
				if(all[i] != thePlayer && all[i].GetTarget() == thePlayer)
					all[i].Kill( 'Debug' );
			}
		}
	}
	
	event OnDbgTeleportToPin( action : SInputAction )
	{
		if( theGame.IsFinalBuild() )
		{
			return false;
		}
		
		if(IsReleased(action))
			thePlayer.DebugTeleportToPin();
	}
	
	
	
	event OnBoatDismount( action : SInputAction )
	{
		var boatComp : CBoatComponent;
		var stopAction : SInputAction;

		stopAction = theInput.GetAction('GI_Decelerate');
		
		if( IsReleased(action) && ( theInput.LastUsedPCInput() || ( stopAction.value < 0.7 && stopAction.lastFrameValue < 0.7 ) ) )
		{
			if( thePlayer.IsActionAllowed( EIAB_DismountVehicle ) )
			{	
				boatComp = (CBoatComponent)thePlayer.GetUsedVehicle().GetComponentByClassName( 'CBoatComponent' );
				boatComp.IssueCommandToDismount( DT_normal );
			}
			else
			{
				thePlayer.DisplayActionDisallowedHudMessage(EIAB_DismountVehicle);
			}
		}
	}

	event OnCiriDrawWeapon( action : SInputAction )
	{
		return super.OnCiriDrawWeapon(action);
	}
	
	event OnCiriHolsterWeapon( action : SInputAction )
	{
		return super.OnCiriHolsterWeapon(action);
	}

	event OnCommHoldFastMenu( action : SInputAction )
	{
		return super.OnCommHoldFastMenu(action);
	}
	
	event OnFastMenu( action : SInputAction )
	{		
		return super.OnFastMenu(action);
	}

	event OnIngameMenu( action : SInputAction )
	{
		var openedPanel : name;
		openedPanel = theGame.GetMenuToOpen(); 
		
		if( IsReleased(action) && openedPanel != 'GlossaryTutorialsMenu' && !theGame.GetGuiManager().IsAnyMenu() ) 
		{
			if ( theGame.IsBlackscreenOrFading() )
			{
				return false;
			}
			theGame.SetMenuToOpen( '' );
			theGame.RequestMenu('CommonIngameMenu' );
		}
	}
	
	event OnToggleHud( action : SInputAction )
	{
		var hud : CR4ScriptedHud;
		if ( IsReleased(action) )
		{
			hud = (CR4ScriptedHud)theGame.GetHud();
			if ( hud )
			{
				hud.ToggleHudByUser();
			}
		}
	}
}
