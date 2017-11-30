class CW3ReduxGamepadState
{
	private var m_defaultInputSet : CW3ReduxGamepadInputSet;
	private var m_modifiedInputSet : CW3ReduxGamepadInputSet;
	private var m_modifierButton : EW3ReduxGamepadButton;
		default m_modifierButton = EW3ReduxGamepadNone;
	private var m_modified : bool;
		default m_modified = false;

	public function initialize() : bool
	{
		m_defaultInputSet = new CW3ReduxGamepadInputSet in this;
		m_modifiedInputSet = new CW3ReduxGamepadInputSet in this;
		
		m_defaultInputSet.initialize();
		m_modifiedInputSet.initialize();
		
		return true;
	}
	
	public function setModifierButton(modifierButton : EW3ReduxGamepadButton)
	{
		m_modifierButton = modifierButton;
	}
	
	public function updateWithNewGamepadStateMap(modInfo : SW3ReduxModInfo, stateMap : IW3ReduxGamepadStateMap) : bool
	{
		var stateMapModifierButton : EW3ReduxGamepadButton;
	
		if(m_modifierButton != EW3ReduxGamepadNone && stateMap.hasModifierButton())
		{
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
		
		if(stateMap.doesOwnBTap())
		{
			m_defaultInputSet.setTapOwner(EW3ReduxGamepadB, stateMap);
		}
		
		if(stateMap.doesOwnXTap())
		{
			m_defaultInputSet.setTapOwner(EW3ReduxGamepadX, stateMap);
		}
		
		if(stateMap.doesOwnYTap())
		{
			m_defaultInputSet.setTapOwner(EW3ReduxGamepadY, stateMap);
		}
		
		//TODO
		return true;
	}
	
	public function hasOwner(mapAction : SW3ReduxMapAction) : bool
	{
		if(mapAction.button == m_modifierButton)
		{
			return true;
		}
		else if(m_modified)
		{
			return m_modifiedInputSet.hasOwner(mapAction);
		}
		else
		{
			return m_defaultInputSet.hasOwner(mapAction);
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