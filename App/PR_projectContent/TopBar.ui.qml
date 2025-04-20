import QtQuick
import QtQuick.Controls

TabBar {
    id: tabBar
    TabButton {
        id: tabControl
        width: 853
        height: 100
        text: qsTr("Sterowanie i podgląd")
        checked: currentTab === "control"
        onClicked: currentTab = "control"
    }

    TabButton {
        id: tabParameters
        x: tabControl.width + 1
        width: 853
        height: 100
        text: qsTr("Parametry")
        checked: currentTab === "parameters"
        onClicked: currentTab = "parameters"
    }

    TabButton {
        id: tabReports
        x: tabControl.width + tabParameters.width + 1
        width: 853
        height: 100
        text: qsTr("Raporty")
        checked: currentTab === "reports"
        onClicked: currentTab = "reports"
    }
}
