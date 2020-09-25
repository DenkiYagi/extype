package extype;

class NotImplementedException extends haxe.Exception {
    public function new(message:String = "not implemented") {
        super(message);
    }
}
