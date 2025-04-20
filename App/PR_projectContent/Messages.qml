import QtQuick

QtObject {
    //      | type |      name         | Message content|
    property string vehicleRotateRight: "Obrót w prawo"
    property string vehicleRotateLeft: "Obrót w lewo"
    property string vehicleMoveForward: "Do przodu"
    property string vehicleReverse: "Wstecz"
    property string cameraRotateRight: "Kamera w prawo"
    property string cameraRotateLeft: "Kamera w lewo"

    // default source
    property string cameraSource: "http://127.0.0.1:8080/stream.mp4"
}
