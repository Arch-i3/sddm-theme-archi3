import QtQuick 2.0
import SddmComponents 2.0

Rectangle {
    id: container
    width: 1920
    height: 1080
    // A színt itt kivettem, mert a kép fogja takarni. 
    // Ha a kép nem töltődik be, alapból fehér/átlátszó lenne, 
    // de az Image alatt lévő color tulajdonságot használhatnád fallbacknek.
    color: "black" 

    // --- ÚJ RÉSZ: HÁTTÉRKÉP KEZELÉSE ---
    Image {
        anchors.fill: parent
        // A theme.conf-ból olvassa a fájl nevét (pl. background.jpg)
        source: config.background 
        // Ez biztosítja, hogy a kép kitöltse a képernyőt torzítás nélkül (levágja a szélét ha kell)
        fillMode: Image.PreserveAspectCrop 
    }
    // ------------------------------------

    // --- BEJELENTKEZŐ DOBOZ ---
    Rectangle {
        anchors.centerIn: parent
        width: 300
        height: 150
        color: "transparent" // Átlátszó, hogy látszódjon mögötte a kép

        Column {
            spacing: 15
            anchors.centerIn: parent
            width: parent.width

            Text {
                text: "Login: " + userModel.lastUser
                color: config.foreground
                font.pixelSize: 24
                anchors.horizontalCenter: parent.horizontalCenter
            }

            PasswordBox {
                id: password
                width: parent.width
                height: 30
                font.pixelSize: 14
                
                // Fókusz kezelése és Enter leütés
                focus: true
                KeyNavigation.backtab: user
                Keys.onPressed: {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        sddm.login(userModel.lastUser, password.text, sessionModel.lastIndex)
                        event.accepted = true
                    }
                }
            }
            
            // Hibaüzenet megjelenítése
            Text {
                text: sddm.loginErrorMessage
                color: "red"
                font.pixelSize: 12
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    // --- ALSÓ SÁV (I3BLOCKS STÍLUS) ---
    Rectangle {
        id: bottomBar
        width: parent.width
        height: 25
        color: config.barColor
        anchors.bottom: parent.bottom

        Row {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 10
            spacing: 15

            // Billentyűzet kiosztás
            Text {
                text: "KB: " + keyboard.layouts[keyboard.currentLayout].shortName
                color: config.foreground
                font.family: "Monospace"
                verticalAlignment: Text.AlignVCenter
            }

            Text { text: "|"; color: "#666666" }

            // --- SAJÁT ÓRA MEGOLDÁS ---
            Text {
                id: customClock
                color: config.foreground
                font.family: "Monospace"
                
                function updateTime() {
                    return Qt.formatDateTime(new Date(), "MM-dd hh:mm:ss")
                }

                text: updateTime()

                Timer {
                    interval: 1000; running: true; repeat: true
                    onTriggered: parent.text = parent.updateTime()
                }
            }
            // --------------------------

            Text { text: "|"; color: "#666666" }

            // Kikapcsolás gomb
            Text {
                text: "Shutdown"
                color: "red"
                font.family: "Monospace"
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: sddm.powerOff()
                }
            }
        }
        
        // Session választó bal oldalon
        Row {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            
            Text {
                text: sessionModel.lastIndex !== -1 ? sessionModel.itemAt(sessionModel.lastIndex) : "Session"
                color: config.accentColor
                font.family: "Monospace"
            }
        }
    }
}
