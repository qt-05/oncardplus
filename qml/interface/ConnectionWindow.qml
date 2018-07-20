import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import Client 1.0
import Server 1.0
import Player 1.0
import "../common"
import "../scenes"

Item {
    id: connection
    visible: false
    z: 50

    Column{
        id: setName
        anchors.centerIn: parent
        height: 10
        anchors.margins: 40
        spacing: 20

        TextField {
            id: inputText

            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 30
            maximumLength: 16
            placeholderText: "127.0.0.1" //初始名
            inputMethodHints: Qt.ImhNoPredictiveText  //不能使用预测性文本（不能查找）
            validator: RegExpValidator{regExp: /^[a-zA-Z0-9äöüßÄÖÜß_ -]{3,}$/}  //文本验证器,必须输入三个及以上字符串

            //输入框
            style: TextFieldStyle {
                textColor: "black"
                background: Rectangle {
                    radius: 30
                    anchors.fill: setName
                    color: "white"
                    border.color: "#28a3c1"
                    border.width: 5
                }
            }

        }
        Row{
        ButtonBase {
            id: listening
            text: "监听"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    server.on_pushButton_Listen_clicked()
                    t.text = server.ipShow()
                }
                }
            }
            Text {
                id: t
                anchors.left: listening.left
                font.family: gameFont.name
                font.pixelSize: 50
                color: "black"
            }
        }

        ButtonBase{
            id :connect
            text: "连接"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    client.connect()
                }
            }
        }

        ButtonBase {
//            anchors.topMargin: 10
            height: (buttonText.height + paddingVertical * 2)
            paddingHorizontal: 8
            paddingVertical: 4
            box.border.width: 5
            box.radius: 30
            textSize: 28
            text: "Do not search a IP now"
            onClicked: connection.visible = false
        }
    }
    Server {
        id: server
        sender: gameWindow.sender
        onSenderChanged: {
            on_pushButton_Send_clicked()
        }
        onReceiveChanged: {
            gameWindow.receive = receive
        }
        onConnectedChanged: {
            if (connected === true) {
                gameWindow.type = 1
                gameWindow.startGame()
            }
        }
    }
    Client {
        id: client
        ip: ip.text
        sender: gameWindow.sender
        onSenderChanged: {
            on_pushButton_Send_clicked()
        }
        onReceiveChanged: {
            gameWindow.receive = receive
        }
        onConnectedChanged: {
            if (connected === true) {
                gameWindow.type = 2
                gameWindow.startGame()
            }
        }
    }
    Player {
        id: player1
        player1_turn: true
    }
    Player {
        id: player2
        player2_turn: true
    }
    Player {
        id: player3
        player3_turn: true
    }
    Player {
        id: player4
        player4_turn: true
    }
}

