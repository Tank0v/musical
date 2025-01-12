import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../utils" as Utils

//Виджет поиска песен по исполнителю
ColumnLayout {
    width: parent.width
    spacing: 15
    Layout.alignment: Qt.AlignCenter

    // Поле ввода имени исполнителя
    Rectangle {
        width: parent.width
        height: 40
        color: "#f7f7f7"
        radius: 5
        border.color: "#ccc"

        TextField {
            id: query
            anchors.fill: parent
            placeholderText: "Введите имя исполнителя"
            font.pointSize: 12
            color: "#333"
            padding: 10
        }
    }

     // Кнопка для поиска
    Rectangle {
        width: parent.width * 0.7
        height: 40
        color: "#006400"
        radius: 5
        border.color: "#004d00"
        Layout.alignment: Qt.AlignHCenter

        Text {
            anchors.centerIn: parent
            text: "Поиск"
            color: "white"
            font.pointSize: 12
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                request.getSongsByArtist(dataModel, query.text)
            }
        }
    }
}