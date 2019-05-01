package extype;

#if js
typedef Error = js.Error;
#else
import haxe.CallStack;

class Error {
    inline static var DEFAULT_NAME = "Error";

    public var message: String;
    public var name: String;
    public var stack(default, null): String;

    public function new(?message : Dynamic) {
        this.message = Maybe.ofNullable(message).getOrElse("");
        this.name = DEFAULT_NAME;
        this.stack = getCallStack();
    }

    inline function getCallStack(): String {
        final callStack = CallStack.callStack();
        callStack.splice(0, 3);
        return CallStack.toString(callStack);
    }
}
#end