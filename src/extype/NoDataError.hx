package extype;

class NoDataError extends Error {
    public function new(message:String = "no data") {
        super(message);
        this.name = "NoDataError";
    }
}
