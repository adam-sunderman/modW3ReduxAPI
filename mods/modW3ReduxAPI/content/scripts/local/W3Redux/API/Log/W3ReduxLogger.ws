/**
 * credit: rmemr
 * directly lifted from bootstrap for witcher 3
 */
 
 
enum EW3ReduxLogLevel 
{
    EW3ReduxLogNone = 0,
    EW3ReduxLogError = 1,
    EW3ReduxLogInfo = 2,
    EW3ReduxLogDebug = 3
}

class CW3ReduxLogger {
	protected var m_channel		: name;
	protected var m_moduleName	: name;
	protected var m_verbosity	: EW3ReduxLogLevel;

	protected final function logOut(level : EW3ReduxLogLevel, levelName : string, msg : string) 
	{
		if (level <= m_verbosity) {
			LogChannel(m_channel, "<" + m_moduleName + " : " + levelName + "> " + msg);
		}
	}

	public function init(modChannelName : name, moduleName : name, verbosity : EW3ReduxLogLevel) 
	{
		m_channel		= modChannelName;
		m_moduleName	= moduleName;
		m_verbosity		= verbosity;
	}

	public function error(msg : string) 
	{
		logOut(EW3ReduxLogError, "Error",  msg);
	}

	public function info(msg : string) 
	{
		logOut(EW3ReduxLogInfo, " Info",  msg);
	}

	public function debug(msg : string) 
	{
		logOut(EW3ReduxLogDebug, "Debug",  msg);
	}
}