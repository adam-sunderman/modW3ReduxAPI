class W3ReduxTestExplorationMap extends IW3ReduxAPIGamepadStateMap
{
	function doesOwnATap() : bool
	{
		return true;
	}
	
	function doesOwnBTap() : bool
	{
		return true;
	}
	
	function doesOwnXTap() : bool
	{
		return true;
	}
	
	function doesOwnYTap() : bool
	{
		return true;
	}
	
	function onATap() : bool
	{
		return W3ReduxCastSign(ST_Yrden);
	}
	
	function onBTap() : bool
	{
		return W3ReduxCastSign(ST_Quen);
	}

	function onXTap() : bool
	{
		return W3ReduxCastSign(ST_Igni);
	}
	
	function onYTap() : bool
	{
		return W3ReduxCastSign(ST_Aard);
	}
}