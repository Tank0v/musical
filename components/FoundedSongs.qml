import QtQuick
import QtQuick.Controls

//Список найденных в поиске песен
Rectangle {
  width: parent ? parent.width - 50 : 300
  height: 100
  anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined
  color: "white"
  radius: 10

  Flickable {
      width: parent.width
      height: parent.height
      contentHeight: column.height

      Column {
          id: column
          anchors.centerIn: parent
          width: parent.width - 20
          spacing: 5
          anchors.horizontalCenter: parent.horizontalCenter

          Text {
              width: parent.width
              wrapMode: Text.WordWrap
              font.pointSize: 10
              text: `<b>Название:</b> ${converter.resize(model.name, 55)}`
              horizontalAlignment: Text.AlignHCenter
          }
          Text {
              width: parent.width
              wrapMode: Text.WordWrap
              font.pointSize: 10
              text: `<b>Исполнитель:</b> ${converter.resize(model.artist, 55)}`
              horizontalAlignment: Text.AlignHCenter
          }
          Text {
              width: parent.width
              wrapMode: Text.WordWrap
              font.pointSize: 10
              visible: {model.listeners ? true : false}
              text: `<b>Прослушиваний:</b> ${model.listeners}`
              horizontalAlignment: Text.AlignHCenter
          }
          Text {
              width: parent.width
              wrapMode: Text.WordWrap
              font.pointSize: 10
              visible: {model.duration ? true : false}
              text: `<b>Длительность:</b> ${converter.secondsToTime(model.duration)}`
              horizontalAlignment: Text.AlignHCenter
          }
            // Кнопка "Подробнее"
            Rectangle {
                width: parent.width * 0.15
                height: 20
                color: "#006400"
                radius: 5
                border.color: "#004d00"
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    anchors.centerIn: parent
                    text: "Подробнее"
                    color: "white"
                    font.pointSize: 12
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        request.getSongInfo(detailedSongModel, model.name, model.artist);
                    }
                }
            }
      }
  }
}

