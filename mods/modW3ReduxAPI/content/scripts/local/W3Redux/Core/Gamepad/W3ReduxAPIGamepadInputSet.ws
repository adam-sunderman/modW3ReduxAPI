class CW3ReduxAPIGamepadInputSet
{
	private var m_AButton : CW3ReduxAPIButton;
	private var m_BButton : CW3ReduxAPIButton;
	private var m_XButton : CW3ReduxAPIButton;
	private var m_YButton : CW3ReduxAPIButton;
	private var m_UpArrow : CW3ReduxAPIButton;
	private var m_DownArrow : CW3ReduxAPIButton;
	private var m_RightArrow : CW3ReduxAPIButton;
	private var m_LeftArrow : CW3ReduxAPIButton;
	private var m_L3 : CW3ReduxAPIButton;
	private var m_R3 : CW3ReduxAPIButton;
	private var m_LBButton : CW3ReduxAPIButton;
	private var m_RBButton : CW3ReduxAPIButton;
	private var m_LTButton : CW3ReduxAPIButton;
	private var m_RTButton : CW3ReduxAPIButton;
	private var m_startButton : CW3ReduxAPIButton;
	private var m_selectButton : CW3ReduxAPIButton;
	private var m_initialized : bool;
		default m_initialized = false;
		
	public function initialize()
	{
		m_AButton = new CW3ReduxAPIButton in this;
		m_BButton = new CW3ReduxAPIButton in this;
		m_YButton = new CW3ReduxAPIButton in this;
		m_XButton = new CW3ReduxAPIButton in this;
		m_UpArrow = new CW3ReduxAPIButton in this;
		m_DownArrow = new CW3ReduxAPIButton in this;
		m_RightArrow = new CW3ReduxAPIButton in this;
		m_LeftArrow = new CW3ReduxAPIButton in this;
		m_L3 = new CW3ReduxAPIButton in this;
		m_R3 = new CW3ReduxAPIButton in this;
		m_LBButton = new CW3ReduxAPIButton in this;
		m_RBButton = new CW3ReduxAPIButton in this;
		m_LTButton = new CW3ReduxAPIButton in this;
		m_RTButton = new CW3ReduxAPIButton in this;
		m_startButton = new CW3ReduxAPIButton in this;
		m_selectButton = new CW3ReduxAPIButton in this;
	
		m_AButton.initialize(EW3ReduxGamepadA);
		m_BButton.initialize(EW3ReduxGamepadB);
		m_YButton.initialize(EW3ReduxGamepadY);
		m_XButton.initialize(EW3ReduxGamepadX);
		m_UpArrow.initialize(EW3ReduxGamepadUp);
		m_DownArrow.initialize(EW3ReduxGamepadDown);
		m_RightArrow.initialize(EW3ReduxGamepadRight);
		m_LeftArrow.initialize(EW3ReduxGamepadLeft);
		m_L3.initialize(EW3ReduxGamepadL3);
		m_R3.initialize(EW3ReduxGamepadR3);
		m_LBButton.initialize(EW3ReduxGamepadLB);
		m_RBButton.initialize(EW3ReduxGamepadRB);
		m_LTButton.initialize(EW3ReduxGamepadLT);
		m_RTButton.initialize(EW3ReduxGamepadRT);
		m_startButton.initialize(EW3ReduxGamepadStart);
		m_selectButton.initialize(EW3ReduxGamepadSelect);
		
		m_initialized = true;
	}
	
	public function setTapOwner(button : EW3ReduxGamepadButton, owner : IW3ReduxAPIGamepadStateMap) : bool
	{
		var cButton : CW3ReduxAPIButton;
		cButton = getButtonFromEnum(button);
		
		if(cButton)
		{
			return cButton.setTapOwner(owner);
		}
		else
		{
			LogChannel('W3ReduxAPI', "Couldn't map button to object to set tap action owner");
		}
		
		return false;
	}
	
	public function setHoldOwner(button : EW3ReduxGamepadButton, owner : IW3ReduxAPIGamepadStateMap) : bool
	{
		var cButton : CW3ReduxAPIButton;
		cButton = getButtonFromEnum(button);
		
		if(cButton)
		{
			if(!cButton.hasHoldOwner())
			{
				return cButton.setHoldOwner(owner);
			}
		}
		
		return false;
	}
	
	public function hasOwner(mapAction : SW3ReduxAPIMapAction) : bool
	{
		var cButton : CW3ReduxAPIButton;
		cButton = getButtonFromEnum(mapAction.button);
		
		if(cButton)
		{
			switch(mapAction.action)
			{
				case EW3ReduxGamepadButtonTap:
					return cButton.hasTapOwner();
				case EW3ReduxGamepadButtonDoubleTap:
					return cButton.hasDoubleTapOwner();
				case EW3ReduxGamepadButtonHold:
					return cButton.hasHoldOwner();
				case EW3ReduxGamepadButtonTappingRapidly:
					return cButton.hasTappingOwner();
			}
		}
		
		return false;
	}
	
	public function acceptAction(button : EW3ReduxGamepadButton, action : SInputAction) : bool
	{
		var cButton : CW3ReduxAPIButton;
		cButton = getButtonFromEnum(button);
		
		if(cButton)
		{
			return cButton.acceptAction(action);
		}
		
		return false;
	}
	
	public function acceptActionHold(button : EW3ReduxGamepadButton, action : SInputAction) : bool
	{
		var cButton : CW3ReduxAPIButton;
		cButton = getButtonFromEnum(button);
		
		if(cButton)
		{
			return cButton.acceptActionHold(action);
		}
		
		return false;
	}
	
	private function getButtonFromEnum(button : EW3ReduxGamepadButton) : CW3ReduxAPIButton
	{
		switch(button)
		{
			case EW3ReduxGamepadA:
				return m_AButton;
			case EW3ReduxGamepadB:
				return m_BButton;
			case EW3ReduxGamepadY:
				return m_YButton;
			case EW3ReduxGamepadX:
				return m_XButton;
		}
		
		return NULL;
	}
}
