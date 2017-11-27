class CW3ReduxAPIGamepadState
{
	private var m_defaultInputSet : CW3ReduxAPIGamepadInputSet;
	private var m_modifiedInputSet : CW3ReduxAPIGamepadInputSet;
	private var m_modifierButton : EW3ReduxGamepadButton;
		default m_modifierButton = EW3ReduxGamepadNone;
	private var m_modified : bool;
		default m_modified = false;

	public function initialize() : bool
	{
		m_defaultInputSet = new CW3ReduxAPIGamepadInputSet in this;
		m_modifiedInputSet = new CW3ReduxAPIGamepadInputSet in this;
		
		m_defaultInputSet.initialize();
		m_modifiedInputSet.initialize();
		
		return true;
	}
	
	public function setModifierButton(modifierButton : EW3ReduxGamepadButton)
	{
		m_modifierButton = modifierButton;
	}
	
	public function updateWithNewGamepadStateMap(modInfo : SW3ReduxAPIModInfo, stateMap : IW3ReduxAPIGamepadStateMap) : bool
	{
		var stateMapModifierButton : EW3ReduxGamepadButton;
	
		if(m_modifierButton != EW3ReduxGamepadNone && stateMap.hasModifierButton())
		{
			W3ReduxAPILogError("CW3ReduxAPIGamepadState::updateWithNewGamepadStateMap(): CONFLICT: Modifier");
			return false;
		}
		
		if(stateMap.getModifierButton(stateMapModifierButton))
		{
			m_modifierButton = stateMapModifierButton;
		}
		
		if(stateMap.doesOwnATap())
		{
			m_defaultInputSet.setTapOwner(EW3ReduxGamepadA, stateMap);
		}
		
		//TODO
		return true;
	}
	
	public function hasHoldOwner(button : EW3ReduxGamepadButton) : bool
	{
		if(button == m_modifierButton)
		{
			return true;
		}
		else if(m_modified)
		{
			return m_modifiedInputSet.hasHoldOwner(button);
		}
		else
		{
			return m_defaultInputSet.hasHoldOwner(button);
		}
	}
	
	public function acceptAction(button : EW3ReduxGamepadButton, action : SInputAction) : bool
	{	
		if(button == m_modifierButton)
		{
			m_modified = IsPressed(action);
			return true;
		}
		else if(m_modified)
		{
			return m_modifiedInputSet.acceptAction(button, action);
		}
		else
		{
			return m_defaultInputSet.acceptAction(button, action);
		}
	}
	
	public function acceptActionHold(button : EW3ReduxGamepadButton, action : SInputAction) : bool
	{
		if(button == m_modifierButton)
		{
			return true;
		}
		
		if(m_modified)
		{
			return m_modifiedInputSet.acceptActionHold(button, action);
		}
		else
		{
			return m_defaultInputSet.acceptActionHold(button, action);
		}
	}
}