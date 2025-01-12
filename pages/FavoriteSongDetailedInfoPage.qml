import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

//Подробная информация о песне из раздела "Избранное"
Column {
    spacing: 10
    Layout.fillWidth: true
    Layout.topMargin: 20
    Layout.leftMargin: 20
    Layout.alignment: Qt.AlignCenter

    property alias favoriteDetailedSongName: favoriteDetailedSongName.text
    property alias favoriteDetailedSongArtist: favoriteDetailedSongArtist.text
    property alias favoriteDetailedSongDescription: favoriteDetailedSongDescription
    property alias favoriteDetailedSongListeners: favoriteDetailedSongListeners.text
    property alias favoriteDetailedSongDuration: favoriteDetailedSongDuration.text
    property alias favoriteDetailedSongAlbum: favoriteDetailedSongAlbum.text
    property alias favoriteDetailedSongAlbumImage: favoriteDetailedSongAlbumImage

 Rectangle {
            width: parent.width * 0.15
            height: 20
            color: "#006400"
            radius: 5
            border.color: "#004d00"
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                anchors.centerIn: parent
                text: "Вернуться назад"
                color: "white"
                font.pointSize: 12
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    layout.currentIndex = 2
                }
            }
    }
    Text {
        id: favoriteDetailedSongName
        Layout.fillWidth: true
        wrapMode: Text.WordWrap
        font.pointSize: 12
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Text {
        id: favoriteDetailedSongArtist
        Layout.fillWidth: true
        wrapMode: Text.WordWrap
        font.pointSize: 12
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Text {
        id: favoriteDetailedSongDescription
        Layout.fillWidth: true
        wrapMode: Text.WordWrap
        font.pointSize: 12
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Text {
        id: favoriteDetailedSongListeners
        Layout.fillWidth: true
        wrapMode: Text.WordWrap
        font.pointSize: 12
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Text {
        id: favoriteDetailedSongDuration
        Layout.fillWidth: true
        wrapMode: Text.WordWrap
        font.pointSize: 12
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Text {
        id: favoriteDetailedSongAlbum
        Layout.fillWidth: true
        wrapMode: Text.WordWrap
        font.pointSize: 12
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Image {
        id: favoriteDetailedSongAlbumImage
        width: 174
        height: 174
        source: ''
        Layout.alignment: Qt.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
