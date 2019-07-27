package extype;

#if js
typedef Error = js.lib.Error;
#else
import haxe.CallStack;

class Error {
    inline static final DEFAULT_NAME = "Error";

    public var message:String;
    public var name:String;
    public var stack(default, null):String;

    public function new(message:String = "") {
        this.message = message;
        this.name = DEFAULT_NAME;
        this.stack = getCallStack();
    }

    inline function getCallStack():String {
        final callStack = CallStack.callStack();
        callStack.splice(0, 2);
        return CallStack.toString(callStack);
    }
}
#end
