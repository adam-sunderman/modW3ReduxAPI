//input states for W3ReduxAPIInputHandling
enum EW3ReduxInputState
{
	EW3ReduxInputExploration,
	EW3ReduxInputCombat,
	EW3ReduxInputSwimming,
	EW3ReduxInputHorse,
	EW3ReduxInputBoat,
	EW3ReduxInputNone
}

//enumerated gamepad buttons handled by W3ReduxAPIInput
enum EW3ReduxGamepadButton
{
	EW3ReduxGamepadA,
	EW3ReduxGamepadB,
	EW3ReduxGamepadY,
	EW3ReduxGamepadX,
	EW3ReduxGamepadUp,
	EW3ReduxGamepadDown,
	EW3ReduxGamepadRight,
	EW3ReduxGamepadLeft,
	EW3ReduxGamepadL3,
	EW3ReduxGamepadR3,
	EW3ReduxGamepadStart,
	EW3ReduxGamepadSelect,
	EW3ReduxGamepadLB,
	EW3ReduxGamepadRB,
	EW3ReduxGamepadRT,
	EW3ReduxGamepadLT,
	EW3ReduxGamepadNone
}

//different actions supported by W3ReduxAPIGamepad monitoring
enum EW3ReduxGamepadButtonAction
{
	EW3ReduxGamepadButtonTap,
	EW3ReduxGamepadButtonDoubleTap,
	EW3ReduxGamepadButtonHold,
	EW3ReduxGamepadButtonTappingRapidly
}

function actionToEW3ReduxGamepadButton(action : SInputAction, optional out button : EW3ReduxGamepadButton) : bool
{
	var gamepadKeys : array<EInputKey>;
	theInput.GetPadKeysForAction(action.aName, gamepadKeys);

	if(gamepadKeys.Size() == 1)
	{
		switch(gamepadKeys[0])
		{
			case IK_Pad_A_CROSS :
				button = EW3ReduxGamepadA;
				return true;
			case IK_Pad_B_CIRCLE :
				button = EW3ReduxGamepadB;
				return true;
			case IK_Pad_X_SQUARE :
				button = EW3ReduxGamepadX;
				return true;
			case IK_Pad_Y_TRIANGLE :
				button = EW3ReduxGamepadY;
				return true;
			case IK_Pad_Start :
				button = EW3ReduxGamepadStart;
				return true;
			case IK_Pad_Back_Select :
			case IK_PS4_OPTIONS :
				button = EW3ReduxGamepadSelect;
				return true;
			case IK_Pad_DigitUp :
				button = EW3ReduxGamepadUp;
				return true;
			case IK_Pad_DigitDown :
				button = EW3ReduxGamepadDown;
				return true;
			case IK_Pad_DigitLeft :
				button = EW3ReduxGamepadLeft;
				return true;
			case IK_Pad_DigitRight :
				button = EW3ReduxGamepadRight;
				return true;
			case IK_Pad_LeftThumb :	
				button = EW3ReduxGamepadL3;
				return true;
			case IK_Pad_RightThumb :
				button = EW3ReduxGamepadR3;
				return true;
			case IK_Pad_LeftShoulder :
				button = EW3ReduxGamepadLB;
				return true;
			case IK_Pad_RightShoulder :
				button = EW3ReduxGamepadRB;
				return true;
			case IK_Pad_LeftTrigger :
				button = EW3ReduxGamepadLT;
				return true;
			case IK_Pad_RightTrigger :
				button = EW3ReduxGamepadRT;
				return true;
		}
	}
	
	return false;
}

function contextNameToW3ReduxInputState(context : name, optional out inputState : EW3ReduxInputState) : bool
{
	switch(context)
	{
		case 'Boat':
			inputState = EW3ReduxInputBoat;
			return true;
		case 'Combat':
			inputState = EW3ReduxInputCombat;
			return true;
		case 'Diving':
		case 'Swimming':
			inputState = EW3ReduxInputSwimming;
			return true;
		case 'Exploration':
		case 'JumpClimb':
			inputState = EW3ReduxInputExploration;
			return true;
		case 'Horse':
			inputState = EW3ReduxInputHorse;
			return true;
	}
	
	return false;
}