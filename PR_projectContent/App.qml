import QtQuick
import PR_project
import Custom 1.0

Window {
    id: mainApp
    width: mainScreen.width
    height: mainScreen.height

    property string currentScreen: "connect"
    property string currentTab: "control"
    property bool isConnecting: false
    property string lastError: ""
    property int enginesPower: 50
    property bool wsadEnabled: false

    visible: true
    title: "PR App"

    Screen01 {
        id: mainScreen
    }

    TcpClient{
        id: tcpClient
    }

    Messages {
        id: messages
    }

    Connections{
        target: tcpClient
        onConnectedToServer: {
            isConnecting = false
            currentScreen = "app"
            lastError = ""
        }
        onDisconnectedFromServer: {
            isConnecting = false
            currentScreen = "connect"
            lastError = "Rozłączono z serwerem."
        }
        onConnectionError: (message) => {
            isConnecting = false
            lastError = message
        }
    }
}

