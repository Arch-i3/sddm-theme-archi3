import QtQuick 2.8
import QtQuick.Controls 2.1

Rectangle {
    width: 640
    height: 480

    // Háttér
    Image {
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
    }

    // Bejelentkező panel középen
    Column {
        anchors.centerIn: parent
        spacing: 10

        TextField {
            id: userField
            width: 200
            placeholderText: "Felhasználónév"
        }

        TextField {
            id: passField
            width: 200
            echoMode: TextInput.Password
            placeholderText: "Jelszó"
            onAccepted: sddm.login(userField.text, passField.text, sessionModel.lastIndex)
        }

        Button {
            text: "Bejelentkezés"
            onClicked: sddm.login(userField.text, passField.text, sessionModel.lastIndex)
        }
    }

    // Alsó sáv i3status információkkal
    Rectangle {
        id: bottomBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 10
        color: "#222D32"

        Text {
            id: statusText
            anchors.right: parent.right
            color: "#ECEFF1"
            font.pixelSize: 14
            text: ""

            Timer {
                interval: 5000
                running: true
                repeat: true
                onTriggered: {
                    var xhr = new XMLHttpRequest();
                    xhr.open("GET", "file:///var/tmp/i3status-sddm.json");
                    xhr.onreadystatechange = function() {
                        if (xhr.readyState === XMLHttpRequest.DONE) {
                            statusText.text = xhr.responseText;
                        }
                    }
                    xhr.send();
                }
            }
        }
    }
}
