import QtQuick
import QtQuick.Controls
import QtQuick.Studio.Components 1.0

GroupItem {
    id: root

    Rectangle {
        id: mainScreen
        width: 481
        height: 240
        border.width: 3
        color: "#ffffff"
    }

    TextField {
        id: ipInput
        x: (mainScreen.width - ipInput.width) / 2 - 80
        y: 105
        width: 120
        placeholderText: qsTr("192.168.xxx.xxx")
    }

    TextField {
        id: portInput
        x: (mainScreen.width - portInput.width) / 2 + 70
        y: 105
        width: 80
        placeholderText: qsTr("1234")
    }

    Text {
        id: title
        x: (mainScreen.width - title.width) / 2
        y: 30
        text: qsTr("Wprowadź dane połączenia")
        font.pixelSize: 20
    }

    Text {
        id: titleIp
        x: ipInput.x
        y: ipInput.y - 25
        text: qsTr("IP")
        font.pixelSize: 16
    }

    Text {
        id: titlePort
        x: portInput.x
        y: portInput.y - 25
        text: qsTr("Port")
        font.pixelSize: 16
    }

    Rectangle {
        id: rectangleButtonConnect
        x: (mainScreen.width - rectangleButtonConnect.width) / 2
        y: 180
        width: 120
        height: 40
        color: "#ffffff"
        border.width: 2

        Button {
            id: buttonConnect
            text: qsTr("Połącz")
            anchors.fill: parent
            anchors.leftMargin: 2
            anchors.rightMargin: 2
            anchors.topMargin: 2
            anchors.bottomMargin: 2
            icon.source: "images/check.png"

            onClicked: {
                tcpClient.connectToHost(ipInput.text,portInput.text);
                mainApp.isConnecting = true
            }

            background: Rectangle {
                color: "#79c72c"
            }
        }
    }
}
