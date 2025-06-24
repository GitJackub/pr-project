import QtQuick
import QtQuick.Controls
import QtQuick.Studio.Components 1.0


GroupItem {
    id: root

    Rectangle {
        id: rectangleForward
        x: 104
        y: 0
        width: 80
        height: 100
        color: "#ffffff"
        border.width: 3
        rotation: 0

        Button {
            id: buttonForward
            visible: true
            text: qsTr("Naprzód")
            anchors.fill: parent
            anchors.leftMargin: 3
            anchors.rightMargin: 3
            anchors.topMargin: 3
            anchors.bottomMargin: 3
            highlighted: false
            flat: false
            icon.height: 50
            icon.width: 50
            icon.source: "images/arrow-upward.png"
            display: AbstractButton.TextUnderIcon
            transformOrigin: Item.Center
            z: 1
            onPressed: {
                tcpClient.sendMessage(messages.vehicleMoveForward)
            }
            onReleased: {
                tcpClient.sendMessage(messages.vehicleStop)
            }
        }
    }

    Rectangle {
        id: rectangleReverse
        x: 104
        y: 105
        width: 80
        height: 100
        color: "#ffffff"
        border.width: 3
        rotation: 0
        Button {
            id: buttonReverse
            visible: true
            text: qsTr("Wstecz")
            anchors.fill: parent
            anchors.leftMargin: 3
            anchors.rightMargin: 3
            anchors.topMargin: 3
            anchors.bottomMargin: 3
            icon.cache: true
            icon.height: 50
            icon.width: 50
            display: AbstractButton.TextUnderIcon
            icon.source: "images/arrow-downward.png"
            z: 1
            transformOrigin: Item.Center
            onPressed: {
                tcpClient.sendMessage(messages.vehicleReverse)
            }
            onReleased: {
                tcpClient.sendMessage(messages.vehicleStop)
            }
        }
    }

    Rectangle {
        id: rectangleRotateLeft
        x: 0
        y: 74
        width: 100
        height: 80
        color: "#ffffff"
        border.width: 3
        rotation: 0
        Button {
            id: buttonRotateLeft
            visible: true
            text: qsTr("Obrót w lewo")
            anchors.fill: parent
            anchors.leftMargin: 3
            anchors.rightMargin: 3
            anchors.topMargin: 3
            anchors.bottomMargin: 3
            font.pointSize: 8
            icon.height: 40
            icon.width: 40
            display: AbstractButton.TextUnderIcon
            icon.source: "images/arrow-turn-around-reverse.png"
            z: 1
            transformOrigin: Item.Center
            onPressed: {
                tcpClient.sendMessage(messages.vehicleRotateLeft)
            }
            onReleased: {
                tcpClient.sendMessage(messages.vehicleStop)
            }
        }
    }

    Rectangle {
        id: rectangleRotateRight
        x: 188
        y: 74
        width: 100
        height: 80
        color: "#ffffff"
        border.width: 3
        rotation: 0
        Button {
            id: buttonRotateRight
            visible: true
            text: qsTr("Obrót w prawo")
            anchors.fill: parent
            anchors.leftMargin: 3
            anchors.rightMargin: 3
            anchors.topMargin: 3
            anchors.bottomMargin: 3
            font.pointSize: 8
            icon.height: 40
            icon.width: 40
            display: AbstractButton.TextUnderIcon
            icon.source: "images/arrow-turn-around.png"
            z: 1
            transformOrigin: Item.Center
            onPressed: {
                tcpClient.sendMessage(messages.vehicleRotateRight)
            }
            onReleased: {
                tcpClient.sendMessage(messages.vehicleStop)
            }
        }
    }

    function handleKeyPressed(event) {
            if (mainApp.wsadEnabled && !event.isAutoRepeat) {
                switch (event.key) {
                    case Qt.Key_W:
                        tcpClient.sendMessage(messages.vehicleMoveForward)
                        break
                    case Qt.Key_S:
                        tcpClient.sendMessage(messages.vehicleReverse)
                        break
                    case Qt.Key_A:
                        tcpClient.sendMessage(messages.vehicleRotateLeft)
                        break
                    case Qt.Key_D:
                        tcpClient.sendMessage(messages.vehicleRotateRight)
                        break
                    case Qt.Key_Q:
                        tcpClient.sendMessage(messages.cameraRotateLeft)
                        break
                    case Qt.Key_E:
                        tcpClient.sendMessage(messages.cameraRotateRight)
                        break
                }
                event.accepted = true
            }
        }

    function handleKeyReleased(event) {
        if (mainApp.wsadEnabled && !event.isAutoRepeat) {
            switch (event.key) {
                case Qt.Key_W:
                case Qt.Key_S:
                case Qt.Key_A:
                case Qt.Key_D:
                    tcpClient.sendMessage(messages.vehicleStop)
                    break
                case Qt.Key_Q:
                case Qt.Key_E:
                    tcpClient.sendMessage(messages.cameraRotateStop)
            }
            event.accepted = true
        }
    }
}
