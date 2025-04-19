import QtQuick
import QtQuick.Controls
import QtQuick.Studio.Components 1.0

GroupItem {
    id: root
    width: 515
    height: 250
    Rectangle {
        id: rectangleRotateLeftCamera
        x: 0
        y: 100
        width: 215
        height: 155
        color: "#ffffff"
        border.width: 4
        rotation: 0

        Button {
            id: buttonRotateLeftCamera
            visible: true
            text: "Obrót w lewo"
            anchors.fill: parent
            anchors.leftMargin: 3
            anchors.rightMargin: 3
            anchors.topMargin: 3
            anchors.bottomMargin: 3
            z: 1
            transformOrigin: Item.Center
            icon.width: 80
            icon.source: "images/arrow-turn-around-reverse.png"
            icon.height: 80
            font.pointSize: 22
            display: AbstractButton.TextUnderIcon
            onClicked: {
                tcpClient.sendMessage(messages.cameraRotateLeft)
            }
        }
    }

    Rectangle {
        id: rectangleRotateRightCamera
        x: 300
        y: 100
        width: 215
        height: 155
        color: "#ffffff"
        border.width: 3
        rotation: 0

        Button {
            id: buttonRotateRightCamera
            visible: true
            text: qsTr("Obrót w prawo")
            anchors.fill: parent
            anchors.leftMargin: 3
            anchors.rightMargin: 3
            anchors.topMargin: 3
            anchors.bottomMargin: 3
            z: 1
            transformOrigin: Item.Center
            icon.width: 80
            icon.source: "images/arrow-turn-around.png"
            icon.height: 80
            font.pointSize: 22
            display: AbstractButton.TextUnderIcon
            onClicked: {
                tcpClient.sendMessage(messages.cameraRotateRight)
            }
        }
    }

    Text {
        id: title
        x: 120
        y: 0
        width: 279
        height: 76
        text: qsTr("Obrót kamery")
        font.pixelSize: 45
    }
}
