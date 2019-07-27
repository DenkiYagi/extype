package extype;

class NotImplementedError extends Error {
    public function new(message:String = "not implemented") {
        super(message);
        this.name = "NotImplementedError";
    }
}
