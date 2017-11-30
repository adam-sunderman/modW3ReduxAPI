class CW3ReduxButton
{
	private var m_log : CW3ReduxLogger;
	private var m_tapOwner : IW3ReduxGamepadStateMap;
	private var m_holdOwner : IW3ReduxGamepadStateMap;
	private var m_doubleTapOwner : IW3ReduxGamepadStateMap;
	private var m_tappingOwner : IW3ReduxGamepadStateMap;
	private var m_button : EW3ReduxGamepadButton;
	private var m_initialized : bool;
		default m_initialized = false;
	private var m_held : bool;
		default m_held = false;
	private var m_isDoubleTapped : bool;
		default m_isDoubleTapped = false;
	private var m_numRapidTaps : int;
		default m_numRapidTaps = 0;
	private var m_tapsPerSecond : float;
		default m_tapsPerSecond = 0.0;
	private var m_pressTimestamp : float;
	private const var DOUBLE_TAP_WINDOW	: float;
		default DOUBLE_TAP_WINDOW = 0.4;
	
	public function initialize(button : EW3ReduxGamepadButton) : bool
	{
		m_log = new CW3ReduxLogger in this;
		m_log.init('W3ReduxAPI', 'Button', EW3ReduxLogDebug);
		m_button = button;
		m_initialized = true;
		return m_initialized;
	}
	
	public function hasOwner(forAction : EW3ReduxGamepadButtonAction) : bool
	{
		return buttonActionToOwner(forAction);
	}
	
	public function hasTapOwner() : bool
	{
		return m_tapOwner;
	}
	
	public function hasHoldOwner() : bool
	{
		return m_holdOwner;
	}
	
	public function hasDoubleTapOwner() : bool
	{
		return m_doubleTapOwner;
	}
	
	public function hasTappingOwner() : bool
	{
		return m_tappingOwner;
	}
	
	public function setTapOwner(owner : IW3ReduxGamepadStateMap) : bool
	{
		if(!m_initialized)
		{
			return false;
		}
		
		m_tapOwner = owner;
		return true;
	}
	
	public function setHoldOwner(owner : IW3ReduxGamepadStateMap) : bool
	{
		if(!m_initialized)
		{
			return false;
		}
		
		m_holdOwner = owner;
		return true;
	}
	
	public function setDoubleTapOwner(owner : IW3ReduxGamepadStateMap) : bool
	{
		if(!m_initialized)
		{
			return false;
		}
		
		m_doubleTapOwner = owner;
		return true;
	}
	
	public function setTappingOwner(owner : IW3ReduxGamepadStateMap) : bool
	{
		if(!m_initialized)
		{
			return false;
		}
		
		m_tappingOwner = owner;
		return true;
	}
	
	public function acceptAction(action : SInputAction) : bool
	{
		if(IsReleased(action))
		{
			if(m_held)
			{
				if(m_holdOwner)
				{
					//return m_holdOwner.OnButtonFinallyReleased();
				}
			}
			else
			{
				if(m_tapOwner)
				{
					m_log.debug("sending tap to tap owner");
					return buttonTapTranslationCall(m_tapOwner);
				}
				m_isDoubleTapped = false;
				m_numRapidTaps = 0;
				m_tapsPerSecond = 0.0;
			}
		}
		
		if(IsPressed(action))
		{
			m_held = false;
			m_pressTimestamp = theGame.GetEngineTimeAsSeconds();
		}
		
		return true;
	}
	
	public function acceptActionHold( action : SInputAction ) : bool
	{
		var i : int;
	
		m_held = true;
		if(m_holdOwner)
		{
			//return m_holdOwner.OnButtonHold();
		}
		
		return true;
	}
	
	private function buttonActionToOwner(actionType : EW3ReduxGamepadButtonAction) : IW3ReduxGamepadStateMap
	{
		switch(actionType)
		{
			case EW3ReduxGamepadButtonTap:
				return m_tapOwner;
			case EW3ReduxGamepadButtonDoubleTap:
				return m_doubleTapOwner;
			case EW3ReduxGamepadButtonHold:
				return m_holdOwner;
			case EW3ReduxGamepadButtonTappingRapidly:
				return m_tappingOwner;
		}
		
		return NULL;
	}
	
	private function buttonTapTranslationCall(owner : IW3ReduxGamepadStateMap) : bool
	{
		switch(m_button)
		{
			case EW3ReduxGamepadA:
				return owner.onATap();
			case EW3ReduxGamepadB:
				return owner.onBTap();
			case EW3ReduxGamepadY:
				return owner.onYTap();
			case EW3ReduxGamepadX:
				return owner.onXTap();
			case EW3ReduxGamepadUp:
			case EW3ReduxGamepadDown:
			case EW3ReduxGamepadRight:
			case EW3ReduxGamepadLeft:
			case EW3ReduxGamepadL3:
			case EW3ReduxGamepadR3:
			case EW3ReduxGamepadStart:
			case EW3ReduxGamepadSelect:
			case EW3ReduxGamepadLB:
			case EW3ReduxGamepadRB:
			case EW3ReduxGamepadRT:
			case EW3ReduxGamepadLT:
				return false;
		}
		
		return false;
	}
}