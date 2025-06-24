import QtQuick

QtObject {
    //      | type |      name         | Message content|
    property string vehicleRotateRight: "6"
    property string vehicleRotateLeft: "5"
    property string vehicleMoveForward: "3"
    property string vehicleReverse: "4"
    property string vehicleStop: "0"

    property string cameraRotateRight: "1"
    property string cameraRotateLeft: "2"
    property string cameraRotateStop: "0"

    // default source
    property string cameraSource: ""

    // to deploy
    // windeployqt PR_projectApp.exe --qmldir=C:\Users\kubam\Documents\repos\pr-project\App-Release\qml
}
