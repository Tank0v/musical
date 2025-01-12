import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

//Подробная информация о песне из раздела поиска
Column {
    spacing: 10
    Layout.fillWidth: true
    Layout.topMargin: 20
    Layout.leftMargin: 20
    Layout.alignment: Qt.AlignCenter

      property alias detailedSongName: detailedSongName.text
      property alias detailedSongArtist: detailedSongArtist.text
      property alias detailedSongDescription: detailedSongDescription
      property alias detailedSongListeners: detailedSongListeners.text
      property alias detailedSongDuration: detailedSongDuration.text
      property alias detailedSongAlbum: detailedSongAlbum.text
      property alias detailedSongAlbumImage: detailedSongAlbumImage

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
                    layout.currentIndex = 0
                }
            }
        }

      Text {
          id: detailedSongName
          Layout.fillWidth: true
          wrapMode: Text.WordWrap
          font.pointSize: 12
          anchors.horizontalCenter: parent.horizontalCenter
      }
      Text {
          id: detailedSongArtist
          Layout.fillWidth: true
          wrapMode: Text.WordWrap
          font.pointSize: 12
          anchors.horizontalCenter: parent.horizontalCenter
      }
      Text {
          id: detailedSongDescription
          Layout.fillWidth: true
          wrapMode: Text.WordWrap
          font.pointSize: 12
          anchors.horizontalCenter: parent.horizontalCenter
      }
      Text {
          id: detailedSongListeners
          width: parent.width
          wrapMode: Text.WordWrap
          font.pointSize: 12
          anchors.horizontalCenter: parent.horizontalCenter
          horizontalAlignment: Text.AlignHCenter
      }
      Text {
          id: detailedSongDuration
          Layout.fillWidth: true
          wrapMode: Text.WordWrap
          font.pointSize: 12
          anchors.horizontalCenter: parent.horizontalCenter
      }
      Text {
          id: detailedSongAlbum
          Layout.fillWidth: true
          wrapMode: Text.WordWrap
          font.pointSize: 12
          anchors.horizontalCenter: parent.horizontalCenter
      }

      Image {
          id: detailedSongAlbumImage
          width: 174
          height: 174
          source: ''
          fillMode: Image.PreserveAspectCrop
          Layout.alignment: Qt.AlignHCenter
          anchors.horizontalCenter: parent.horizontalCenter
      }
}