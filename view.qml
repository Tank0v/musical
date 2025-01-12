import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.LocalStorage
import QtQuick.Controls
import "Database.js" as JS
import "components" as Components
import "utils" as Utils
import "pages" as Pages
import "handlers/SongModelHandlers.js" as Handlers

Window {
    id: window
    visible: true
    width: Screen.width / 2
    height: Screen.height / 1.8
    title: qsTr("Musical Info")
    color: "#8FBC8F"

    Utils.Converter { id: converter }
    Utils.RequestService { id: request }

    // Верхнее меню
    Components.MenuBar { id: bar }

    // Переключение между страницами приложения
    StackLayout {
        id: layout
        anchors.top: bar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        property alias isLabelNotFoundVisible: labelNotFound.visible

        // Модель выбранной песни
        ListModel {
            id: detailedSongModel
            onCountChanged: {
                Handlers.onCountChangedHandler(detailedSongModel, songInfoPage, layout, favoritesButton, converter, JS);
            }
        }

        // Основная страница поиска песен
        Row {
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            width: window.width
            height: window.height - bar.height - 30

            Rectangle {
                width: window.width / 2
                height: parent.height
                color: "transparent"

                Column {
                    width: parent.width * 0.8
                    spacing: 30
                    anchors.centerIn: parent

                    // Виджеты поиска
                    Components.SearchSongNameQuery {}
                    Components.SearchSongArtistQuery {}
                    Components.SearchSongAlbumQuery {}
                }
            }

            ListModel { id: songModel }
            ListModel { id: dataModel }

            // Список найденных песен
             Rectangle {
                width: window.width / 2
                height: parent.height
                color: "#8FBC8F"

                Flickable {
                    id: listViewFlickable
                    width: parent.width
                    height: parent.height
                    contentHeight: listView.contentHeight
                    ListView {
                        id: listView
                        height: parent.height
                        width: parent.width
                        model: dataModel

                        Label {
                            id: labelNotFound
                            height: 30
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            color: "red"
                            text: "К сожалению, по данному запросу песен не найдено"
                            font.pointSize: 12
                            visible: false
                        }
                        delegate: Components.FoundedSongs {}
                    }
                }
            }
        }

        // Страница с информацией о песне из поиска
        Pages.SongDetailedInfoPage {
            id: songInfoPage
            Layout.alignment: Qt.AlignCenter
            Components.AddToFavorites { id: favoritesButton }
        }

        // Список избранных песен
        Rectangle {
            width: parent.width
            height: window.height - bar.height - 30
            color: "#8FBC8F"

            ListModel { id: songListModel }

            // Оборачиваем Flickable в Item для выравнивания
            Item {
                width: parent.width * 0.8
                height: parent.height * 0.8
                anchors.centerIn: parent

                Flickable {
                    id: listViewFlickable2
                    width: parent.width
                    height: parent.height
                    contentHeight: listView2.contentHeight

                    ListView {
                        id: listView2
                        width: parent.width
                        height: parent.height
                        spacing: 5
                        model: songListModel

                        delegate: Components.FavoriteSongsList {}
                    }
                }
            }
        }

        // Страница с информацией о песне из избранного
        Pages.FavoriteSongDetailedInfoPage {
            id: favoriteSongInfoPage
            Layout.alignment: Qt.AlignCenter
        }
    }

    Component.onCompleted: {
        JS.dbInit()
        dataModel.clear()
        JS.dbReadAllSongs()
    }
}

