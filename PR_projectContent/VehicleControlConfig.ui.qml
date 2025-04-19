import QtQuick
import QtQuick.Controls
import QtQuick.Studio.Components 1.0

GroupItem {
    id: root
    width: 446
    height: 437
    Text {
        id: minValue
        x: 19
        y: 252
        text: qsTr("0")
        font.pixelSize: 50
    }

    Text {
        id: maxValue
        x: 338
        y: 252
        text: qsTr("100")
        font.pixelSize: 50
    }

    Text {
        id: title
        x: 0
        y: 146
        text: qsTr("Moc silników [%]")
        font.pixelSize: 60
    }

    Slider {
        id: sliderEnginesPower
        x: 19
        y: 325
        width: 400
        value: 50
        stepSize: 1
        to: 100
    }

    Text {
        id: currentSliderValue
        x: 187
        y: 377
        text: sliderEnginesPower.value.toFixed(0)
        font.pixelSize: 45
    }

    Switch {
        id: switchControlWSAD
        width: 438
        height: 135
        text: qsTr("Sterowanie WSAD")
        spacing: 20
        autoExclusive: false
        checked: false
        display: AbstractButton.TextUnderIcon
        font.pointSize: 30
    }

    Item {
        id: controlKeyboard
        focus: switchControlWSAD
    }
}
