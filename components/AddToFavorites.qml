import QtQuick
import QtQuick.Controls
import QtQuick.LocalStorage
import "../Database.js" as JS

//Кнопка "Добавить в избранное"
Rectangle {
    id: addToFavoritesButton
    width: parent.width * 0.15
    height: 20
    color: "#006400"
    radius: 5
    border.color: "#004d00"
    anchors.horizontalCenter: parent.horizontalCenter

    Text {
        anchors.centerIn: parent
        text: "Добавить в избранное"
        color: "white"
        font.pointSize: 12
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            var song = detailedSongModel.get(0)
            JS.dbInsertSong(song.name, song.artist, song.album,
                    song.duration, song.description, song.image, song.listeners)

            // Выключить добавление в избранное, когда элемент уже добавлен
            addToFavoritesButton.enabled = false
        }
    }
}