/*!
 * brief: unique identification and designation for a mod.
 * param: id - unique identifier for mod (PLEASE USE NEXUS MOD ID THAT IS ASSIGNED TO YOU)
 * param: designator - human readable name for mod - note: doesn't have to be unique
 *
 * SW3ReduxAPIModInfo are used to map a mods unique itentity to up to 1 IW3ReduxAPIGamepadStateMap per
 * EW3ReduxAPIInputState
 */
struct SW3ReduxAPIModInfo
{
        var id : int;
        var designator : string;
};

/*!
 * brief: API for mods to integrate with the W3Redux Gamepad Entity.
 *
 * The IW3ReduxAPIGamepad provides means for a mod to install its gamepad bindings for states via the
 * IW3ReduxAPIGamepadStateMap interface. This interface also provides a way for a mod to uninstall or
 * "reset" its bindings (useful if your mod allows for multiple controller schemes)
 */
abstract class IW3ReduxAPIGamepad
{
        /*!
         * brief: updates IW3ReduxAPIGamepad for desired EW3ReduxInputState for specified mod
         * param: modInfo - unique identifier of mod attempting to install bindings
         * param: forState - state the mod is attempting to install bindings for
         * param: stateMap - implementation of IW3ReduxAPIGamepadStateMap that communicates the mods desired bindings for desired state
         * return: true - mod bindings installed for state. no conflicts
         * return: false - mod findings not installed for state. conflicts are present. will show in logs and controller scheme UI
         *
         * Once called, the gamepad will utilize the provided IW3ReduxAPIGamepadStateMap and will fire events when necessary back to the mod.
         * Controller Scheme UI and control hints will be updated automatically by W3ReduxAPI
         */
        public function updateWithNewGamepadStateMap(modInfo : SW3ReduxAPIModInfo, forState : EW3ReduxInputState,
                stateMap : IW3ReduxAPIGamepadStateMap) : bool;

        /*!
         * brief: clears all bindings for all states for specified mod. Essentially a "reset".
         * param: modInfo - unique identifier of mod attempting to uninstall bindings
         * return: true - all bindings uninstalled
         * return: false - internal error... should probably assert or something. May switch this to void.
         */
        public function clearModGamepadStateMaps(modInfo : SW3ReduxAPIModInfo) : bool;
}

/*!
 * brief: global factory to get instance of the IW3ReduxAPIGamepad API
 * return: IW3ReduxAPIGamepad - singleton IW3ReduxAPIGamepad for mods to use to install and clear bindings
 */
function GetW3ReduxGamepadInterface() : IW3ReduxAPIGamepad
{
        //placeholder vars
        var playerWitcher : W3PlayerWitcher;
        var inputHandler : CW3ReduxAPIInput;

        //get input handler
        playerWitcher = GetWitcherPlayer();
        inputHandler = (CW3ReduxAPIInput) playerWitcher.GetInputHandler();

        //input handler is able to give us the gamepad instance
        return inputHandler.getGamepad();
}