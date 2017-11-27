class W3ReduxTestExplorationMap extends IW3ReduxAPIGamepadStateMap
{
	function doesOwnATap() : bool
	{
		return true;
	}
	
	function onATap() : bool
	{
		W3ReduxAPILogInfo("W3ReduxTestExplorationMap::onATap() FIRED!");
		return true;
	}
}