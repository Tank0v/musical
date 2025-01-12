import QtQuick
import QtQuick.Controls
import QtQuick.LocalStorage
import "../Database.js" as JS

// Верхнее меню приложения
TabBar {
    id: bar
    width: parent.width
    height: 40
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    clip: true

    background: Rectangle {
        color: "#41B3A3"
        anchors.fill: parent
    }

    TabButton {
        implicitWidth: bar.width / 2
        implicitHeight: bar.height
        height: bar.height

        background: Rectangle {
            color: currentIndex === 0 ? "#006400" : "#90EE90"
            radius: 5
            anchors.fill: parent
        }

        contentItem: Item {
            anchors.fill: parent
            Text {
                anchors.centerIn: parent
                text: qsTr("Главная")
                color: currentIndex === 0 ? "white" : "black"
                font.bold: true
                font.pointSize: 14
            }
        }
    }

    TabButton {
        implicitWidth: bar.width / 2
        implicitHeight: bar.height

        background: Rectangle {
            color: currentIndex === 1 ? "#006400" : "#90EE90"
            radius: 5
            anchors.fill: parent
        }

        contentItem: Item {
            anchors.fill: parent
            Text {
                anchors.centerIn: parent
                text: qsTr("Избранное")
                color: currentIndex === 1 ? "white" : "black"
                font.bold: true
                font.pointSize: 14
            }
        }
    }

    onCurrentIndexChanged: {
        if (currentIndex === 0) {
            layout.currentIndex = 0
        } else {
            JS.dbReadAllSongs()
            layout.currentIndex = 2
        }
    }
}
