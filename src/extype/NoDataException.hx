package extype;

class NoDataException extends Exception {
    public function new(message:String = "no data") {
        super(message);
    }
}
