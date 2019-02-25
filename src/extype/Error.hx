package extype;

#if js
typedef Error = js.Error;
#else
import haxe.CallStack;

class Error {
    private inline static var DEFAULT_NAME = "Error";

    public var message(default, default): String;
    public var name(default, default): String;
    public var stack(default, null): String;

    public function new(?message : Dynamic) {
        this.message = Maybe.ofNullable(message).getOrElse("");
        this.name = DEFAULT_NAME;
        this.stack = getCallStack();
    }

    private static function getCallStack(): String {
        var callStack = CallStack.callStack();
        callStack.splice(0, 3);
        return CallStack.toString(callStack);
    }
}
#end