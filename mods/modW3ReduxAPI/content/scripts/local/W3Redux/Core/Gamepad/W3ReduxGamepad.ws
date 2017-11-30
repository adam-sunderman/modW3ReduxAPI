struct SW3ReduxMapAction
{
	var button : EW3ReduxGamepadButton;
	var action : EW3ReduxGamepadButtonAction;
};

struct SW3ReduxModInfoInternal
{
	var info : SW3ReduxModInfo;
	var ownedActions : array<SW3ReduxMapAction>;
};

class CW3ReduxGamepad extends IW3ReduxGamepad
{
	private var m_ExplorationPad	: CW3ReduxGamepadState;
	private var m_CombatPad 		: CW3ReduxGamepadState;
	private var m_SwimPad 			: CW3ReduxGamepadState;
	private var m_HorsePad			: CW3ReduxGamepadState;
	private var m_BoatPad 			: CW3ReduxGamepadState;
	private var m_currentInputState	: EW3ReduxInputState;
		default m_currentInputState = EW3ReduxInputNone;
	private var m_initialized 		: bool;
		default m_initialized		= false;
		
	public function initialize() : bool
	{
		m_ExplorationPad = new CW3ReduxGamepadState in this;
		m_CombatPad = new CW3ReduxGamepadState in this;
		m_SwimPad = new CW3ReduxGamepadState in this;
		m_HorsePad = new CW3ReduxGamepadState in this;
		m_BoatPad = new CW3ReduxGamepadState in this;
		
		m_ExplorationPad.initialize();
		m_CombatPad.initialize();
		m_SwimPad.initialize();
		m_HorsePad.initialize();
		m_BoatPad.initialize();
		
		m_initialized = true;
		return m_initialized;
	}
	
	public function getExplorationPad() : CW3ReduxGamepadState
	{
		return m_ExplorationPad;
	}
	
	public function getCombatPad() : CW3ReduxGamepadState
	{
		return m_CombatPad;
	}
	
	public function getSwimPad() : CW3ReduxGamepadState
	{
		return m_SwimPad;
	}
	
	public function getHorsePad() : CW3ReduxGamepadState
	{
		return m_HorsePad;
	}
	
	public function getBoatPad() : CW3ReduxGamepadState
	{
		return m_BoatPad;
	}
	
	public function setInputState(inputState : EW3ReduxInputState)
	{
		m_currentInputState = inputState;
	}
	
	public function updateWithNewGamepadStateMap(modInfo : SW3ReduxModInfo, forState : EW3ReduxInputState, 
		stateMap : IW3ReduxGamepadStateMap) : bool
	{
		var padState : CW3ReduxGamepadState;
		padState = getPadStateFromEnum(forState);
	
		if(padState)
		{
			return padState.updateWithNewGamepadStateMap(modInfo, stateMap);
		}
		
		return false;
	}
	
	public function clearModGamepadStateMaps(modInfo : SW3ReduxModInfo) : bool
	{
		//m_BoatPad.clearModGamepadStateMaps(modInfo);
		//m_CombatPad.clearModGamepadStateMaps(modInfo);
		//m_ExplorationPad.clearModGamepadStateMaps(modInfo);
		//m_HorsePad.clearModGamepadStateMaps(modInfo);
		//m_SwimPad.clearModGamepadStateMaps(modInfo);
		
		return true;
	}
	
	public function hasOwnerInCurrentState(mapAction : SW3ReduxMapAction) : bool
	{
		var currentPadState : CW3ReduxGamepadState;
		currentPadState = getPadStateFromEnum(m_currentInputState);
		
		if(currentPadState)
		{
			return currentPadState.hasOwner(mapAction);
		}
		
		return false;
	}
	
	public function acceptAction(button : EW3ReduxGamepadButton, action : SInputAction) : bool
	{
		var currentPadState : CW3ReduxGamepadState;
		currentPadState = getPadStateFromEnum(m_currentInputState);
		
		if(currentPadState)
		{
			return currentPadState.acceptAction(button, action);
		}
		
		return false;
	}
	
	public function acceptActionHold(button : EW3ReduxGamepadButton, action : SInputAction) : bool
	{
		var currentPadState : CW3ReduxGamepadState;
		currentPadState = getPadStateFromEnum(m_currentInputState);
		
		if(currentPadState)
		{
			return currentPadState.acceptActionHold(button, action);
		}
		
		return false;
	}
	
	private function getPadStateFromEnum(padStateEnum : EW3ReduxInputState) : CW3ReduxGamepadState
	{
		switch(padStateEnum)
		{
			case EW3ReduxInputExploration:
				return m_ExplorationPad;
			case EW3ReduxInputCombat:
				return m_CombatPad;
			case EW3ReduxInputSwimming:
				return m_SwimPad;
			case EW3ReduxInputHorse:
				return m_HorsePad;
			case EW3ReduxInputBoat:
				return m_BoatPad;
		}
		
		return NULL;
	}
}