enum EW3ReduxStringUIDisplayMode
{
	EW3ReduxStringUIDisplayLocalizedKey = 0,
	EW3ReduxStringUIDisplayHardCodedString = 1
}

abstract class IW3ReduxAPIGamepadStateMap
{
	public function hasModifierButton() : bool
	{
		return false;
	}
	
	public function getModifierButton(optional out modifierButton : EW3ReduxGamepadButton) : bool
	{
		return false;
	}

	public function doesOwnATap() : bool
	{
		return false;
	}
	
	public function doesOwnAHold() : bool
	{
		return false;
	}
	
	public function doesOwnADoubleTap() : bool
	{
		return false;
	}
	
	public function doesOwnATappingRapidly() : bool
	{
		return false;
	}
	
	public function doesOwnBTap() : bool
	{
		return false;
	}
	
	public function doesOwnBHold() : bool
	{
		return false;
	}
	
	public function doesOwnBDoubleTap() : bool
	{
		return false;
	}
	
	public function doesOwnBTappingRapidly() : bool
	{
		return false;
	}
	
	public function doesOwnXTap() : bool
	{
		return false;
	}
	
	public function doesOwnXHold() : bool
	{
		return false;
	}
	
	public function doesOwnXDoubleTap() : bool
	{
		return false;
	}
	
	public function doesOwnXTappingRapidly() : bool
	{
		return false;
	}
	
	public function doesOwnYTap() : bool
	{
		return false;
	}
	
	public function doesOwnYHold() : bool
	{
		return false;
	}
	
	public function doesOwnYDoubleTap() : bool
	{
		return false;
	}
	
	public function doesOwnYTappingRapidly() : bool
	{
		return false;
	}
	
	public function onATap() : bool
	{
		return false;
	}
	
	public function onAHold() : bool
	{
		return false;
	}
	
	public function onADoubleTap() : bool
	{
		return false;
	}
	
	public function onATappingRapidly(numRapidTaps : int, currentTapsPerSecondAvg : float) : bool
	{
		return false;
	}
	
	public function onBTap() : bool
	{
		return false;
	}
	
	public function onBHold() : bool
	{
		return false;
	}
	
	public function onBDoubleTap() : bool
	{
		return false;
	}
	
	public function onBTappingRapidly(numRapidTaps : int, currentTapsPerSecondAvg : float) : bool
	{
		return false;
	}
	
	public function onXTap() : bool
	{
		return false;
	}
	
	public function onXHold() : bool
	{
		return false;
	}
	
	public function onXDoubleTap() : bool
	{
		return false;
	}
	
	public function onXTappingRapidly(numRapidTaps : int, currentTapsPerSecondAvg : float) : bool
	{
		return false;
	}
	
	public function onYTap() : bool
	{
		return false;
	}
	
	public function onYHold() : bool
	{
		return false;
	}
	
	public function onYDoubleTap() : bool
	{
		return false;
	}
	
	public function onYTappingRapidly(numRapidTaps : int, currentTapsPerSecondAvg : float) : bool
	{
		return false;
	}
	
	public function getModifierDisplay(out displayStringKeyOrRaw : string) : EW3ReduxStringUIDisplayMode
	{
		displayStringKeyOrRaw = "W3ReduxPlaceHolder";
		return EW3ReduxStringUIDisplayHardCodedString;
	}
	
	public function getATapDisplay(out displayStringKeyOrRaw : string) : EW3ReduxStringUIDisplayMode
	{
		displayStringKeyOrRaw = "W3ReduxPlaceHolder";
		return EW3ReduxStringUIDisplayHardCodedString;
	}
	
	public function getAHoldDisplay(out displayStringKeyOrRaw : string) : EW3ReduxStringUIDisplayMode
	{
		displayStringKeyOrRaw = "W3ReduxPlaceHolder";
		return EW3ReduxStringUIDisplayHardCodedString;
	}
	
	public function getADoubleTapDisplay(out displayStringKeyOrRaw : string) : EW3ReduxStringUIDisplayMode
	{
		displayStringKeyOrRaw = "W3ReduxPlaceHolder";
		return EW3ReduxStringUIDisplayHardCodedString;
	}
	
	public function getARapidlyTappingDisplay(out displayStringKeyOrRaw : string) : EW3ReduxStringUIDisplayMode
	{
		displayStringKeyOrRaw = "W3ReduxPlaceHolder";
		return EW3ReduxStringUIDisplayHardCodedString;
	}
	
	public function getBTapDisplay(out displayStringKeyOrRaw : string) : EW3ReduxStringUIDisplayMode
	{
		displayStringKeyOrRaw = "W3ReduxPlaceHolder";
		return EW3ReduxStringUIDisplayHardCodedString;
	}
	
	public function getBHoldDisplay(out displayStringKeyOrRaw : string) : EW3ReduxStringUIDisplayMode
	{
		displayStringKeyOrRaw = "W3ReduxPlaceHolder";
		return EW3ReduxStringUIDisplayHardCodedString;
	}
	
	public function getBDoubleTapDisplay(out displayStringKeyOrRaw : string) : EW3ReduxStringUIDisplayMode
	{
		displayStringKeyOrRaw = "W3ReduxPlaceHolder";
		return EW3ReduxStringUIDisplayHardCodedString;
	}
	
	public function getBRapidlyTappingDisplay(out displayStringKeyOrRaw : string) : EW3ReduxStringUIDisplayMode
	{
		displayStringKeyOrRaw = "W3ReduxPlaceHolder";
		return EW3ReduxStringUIDisplayHardCodedString;
	}
	
	public function getXTapDisplay(out displayStringKeyOrRaw : string) : EW3ReduxStringUIDisplayMode
	{
		displayStringKeyOrRaw = "W3ReduxPlaceHolder";
		return EW3ReduxStringUIDisplayHardCodedString;
	}
	
	public function getXHoldDisplay(out displayStringKeyOrRaw : string) : EW3ReduxStringUIDisplayMode
	{
		displayStringKeyOrRaw = "W3ReduxPlaceHolder";
		return EW3ReduxStringUIDisplayHardCodedString;
	}
	
	public function getXDoubleTapDisplay(out displayStringKeyOrRaw : string) : EW3ReduxStringUIDisplayMode
	{
		displayStringKeyOrRaw = "W3ReduxPlaceHolder";
		return EW3ReduxStringUIDisplayHardCodedString;
	}
	
	public function getXRapidlyTappingDisplay(out displayStringKeyOrRaw : string) : EW3ReduxStringUIDisplayMode
	{
		displayStringKeyOrRaw = "W3ReduxPlaceHolder";
		return EW3ReduxStringUIDisplayHardCodedString;
	}
	
	public function getYTapDisplay(out displayStringKeyOrRaw : string) : EW3ReduxStringUIDisplayMode
	{
		displayStringKeyOrRaw = "W3ReduxPlaceHolder";
		return EW3ReduxStringUIDisplayHardCodedString;
	}
	
	public function getYHoldDisplay(out displayStringKeyOrRaw : string) : EW3ReduxStringUIDisplayMode
	{
		displayStringKeyOrRaw = "W3ReduxPlaceHolder";
		return EW3ReduxStringUIDisplayHardCodedString;
	}
	
	public function getYDoubleTapDisplay(out displayStringKeyOrRaw : string) : EW3ReduxStringUIDisplayMode
	{
		displayStringKeyOrRaw = "W3ReduxPlaceHolder";
		return EW3ReduxStringUIDisplayHardCodedString;
	}
	
	public function getYRapidlyTappingDisplay(out displayStringKeyOrRaw : string) : EW3ReduxStringUIDisplayMode
	{
		displayStringKeyOrRaw = "W3ReduxPlaceHolder";
		return EW3ReduxStringUIDisplayHardCodedString;
	}
}