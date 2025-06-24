

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick
import QtQuick.Controls
import PR_project
import QtQuick.Layouts
import QtQuick.Studio.Components 1.0
import QtMultimedia

Item {
    id: screen01
    width: Constants.width
    height: Constants.height

    focus: true
    Keys.enabled: true

    Rectangle {
        id: background
        width: parent.width
        height: parent.height

        color: Constants.backgroundColor
    }

    Item {
        id: appScreen
        width: parent.width
        height: parent.height
        visible: mainApp.currentScreen === "app"

        TopBar {
            id: tabBar
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 0
            contentHeight: 100
            contentWidth: parent.width
            font.pointSize: 20
            height: 100
            position: TabBar.Header
            visible: true
            width: parent.width
        }

        Item {
            id: tabs
            y: tabBar.height
            width: parent.width
            height: parent.height - tabBar.height

            Item {
                id: tabControl
                width: parent.width
                height: parent.height
                visible: mainApp.currentTab === "control"

                CameraControl {
                    id: cameraControl
                    height: 254
                    width: 515
                    x: 567
                    y: 967
                }

                VehicleControl {
                    id: vehicleControl
                    x: 1849
                    y: 422
                    scale: 2.2
                }

                VehicleControlConfig {
                    id: vehicleControlConfig
                    x: 1770
                    y: 812
                }

                CameraView {
                    id: cameraView
                    border.width: 4
                    color: "#ffffff"
                    height: 720
                    width: 1280
                    x: 185
                    y: 170
                }
            }
        }
    }

    Item {
        id: connectScreen
        width: parent.width
        height: parent.height
        visible: mainApp.currentScreen === "connect"

        ConnectPanel {
            id: connectPanel
            x: 1040
            y: 595
            scale: 2
        }
        Rectangle {
            id: rectangleBusyIndicator
            width: 150
            height: 150
            anchors.centerIn: parent
            opacity: 0.5
            color: "#000000"
            visible: mainApp.isConnecting

            BusyIndicator {
                running: mainApp.isConnecting
                anchors.centerIn: parent
                width: 0.7 * parent.width
                height: 0.7 * parent.height
            }
        }
        Text {
            id: displayError
            text: mainApp.lastError
            color: "red"
            font.pixelSize: 22
            anchors.horizontalCenter: parent.horizontalCenter
            y: 0.7 * connectScreen.height
        }
    }
    Keys.onPressed: (event) => {
        vehicleControl.handleKeyPressed(event)
    }

    Keys.onReleased: (event) => {
        vehicleControl.handleKeyReleased(event)
    }
    Component.onCompleted: screen01.forceActiveFocus()
}
