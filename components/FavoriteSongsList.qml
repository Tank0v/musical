import QtQuick
import QtQuick.Controls
import "../Database.js" as JS

//Страница с избранными песнями
Rectangle {
    width: parent.width - 30
    height: 100
    anchors.horizontalCenter: parent.horizontalCenter
    color: "white"
    radius: 10

    Flickable {
        width: parent.width
        height: parent.height

        // Основной Row для текста и кнопок
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width

            Column {
                width: parent.width * 0.6
                spacing: 5

                Text {
                    width: parent.width
                    wrapMode: Text.WordWrap
                    font.pointSize: 10
                    text: `<b>Название:</b> ${converter.resize(model.name, 55)}`
                }

                Text {
                    width: parent.width
                    wrapMode: Text.WordWrap
                    font.pointSize: 10
                    text: `<b>Исполнитель:</b> ${converter.resize(model.artist, 55)}`
                }

                Text {
                    width: parent.width
                    wrapMode: Text.WordWrap
                    font.pointSize: 10
                    text: `<b>Прослушиваний:</b> ${model.listeners}`
                }
            }

            anchors.verticalCenter: parent.verticalCenter
            spacing: 10

            // Кнопка "Подробнее"
            Rectangle {
                width: parent.width * 0.15
                height: 40
                color: "#006400"
                radius: 5
                border.color: "#004d00"

                Text {
                    anchors.centerIn: parent
                    text: "Подробнее"
                    color: "white"
                    font.pointSize: 12
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        JS.dbSongInfo(model.id)
                        var currentSong = songModel.get(0)
                        favoriteSongInfoPage.favoriteDetailedSongName = `<b>Название:</b> ${currentSong.name}` ;
                        favoriteSongInfoPage.favoriteDetailedSongArtist = `<b>Исполнитель:</b> ${currentSong.artist}` ;
                        if (currentSong.description) {
                            favoriteSongInfoPage.favoriteDetailedSongDescription.visible = true;
                            favoriteSongInfoPage.favoriteDetailedSongDescription.text = `<b>Описание:</b> ${currentSong.description}` ;
                        } else {
                            favoriteSongInfoPage.favoriteDetailedSongDescription.visible = false;
                        }
                        favoriteSongInfoPage.favoriteDetailedSongListeners = `<b>Прослушали: </b> ${currentSong.listeners}` ;
                        favoriteSongInfoPage.favoriteDetailedSongDuration = `<b>Длительность: </b> ${currentSong.duration > 0 ? converter.msToTime(currentSong.duration) : "Длительность трека отсутствует"}` ;
                        favoriteSongInfoPage.favoriteDetailedSongAlbum = currentSong.album ? `<b>Альбом:</b> ${currentSong.album}` : '' ;
                        if (currentSong.image) {
                            favoriteSongInfoPage.favoriteDetailedSongAlbumImage.visible = true;
                            favoriteSongInfoPage.favoriteDetailedSongAlbumImage.source = currentSong.image;
                        } else {
                            favoriteSongInfoPage.favoriteDetailedSongAlbumImage.visible = false;
                        }

                        layout.currentIndex = 3;
                    }
                }
            }

            // Кнопка "Удалить"
            Rectangle {
                width: parent.width * 0.15
                height: 40
                color: "#B22222"
                radius: 5
                border.color: "#8B0000"

                Text {
                    anchors.centerIn: parent
                    text: "Удалить"
                    color: "white"
                    font.pointSize: 12
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        JS.deleteSong(model.id) // Удаление песни из базы данных
                        songListModel.remove(index) // Удаление из модели
                    }
                }
            }

        }

    }
}



