import QtMultimedia
import QtQuick


Rectangle {
    id: rectangleVideo
    MediaPlayer {
        id: player
        source: ""
        videoOutput: videoOutput
    }
    VideoOutput {
        id:videoOutput
        anchors.fill: parent
        endOfStreamPolicy: VideoOutput.KeepLastFrame
    }
    onVisibleChanged: {
        if(visible){
            player.source = messages.cameraSource
            player.play()
        }
        else{
            player.pause()
            player.source = ""
        }
    }
}
