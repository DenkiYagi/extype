package extype;

#if (haxe > version("4.1.0"))
typedef Exception = haxe.Exception;
#else
import haxe.CallStack;

class Exception #if js extends js.lib.Error #end {
    #if !js
    public final message:String;
    public final stack:CallStack;
    #end
    public final previous:Null<Exception>;

    public function new(message:String, ?previous:Exception) {
        #if js
        super();
        #end
        this.message = message;
        this.previous = previous;
        #if !js
        this.stack = getCallStack();
        #end
    }

    #if !js
    inline function getCallStack():CallStack {
        final callStack = CallStack.callStack();
        callStack.splice(0, 2);
        return callStack;
    }
    #end
}
#end
