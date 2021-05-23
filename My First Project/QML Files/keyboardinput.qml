import QtQuick 2.0
import QtQuick.VirtualKeyboard 2.4
import QtQuick.VirtualKeyboard.Settings 2.2
import QtQuick.VirtualKeyboard.Styles 2.2
import QtQuick.Controls 2.12

ApplicationWindow{
    id:root
    width:400
    height:400
    visible:true
    Rectangle{
        anchors.fill: root
        id:rect
            TextField{
                id:digitsony
                anchors.centerIn: rect
                width:250
                height:50
                placeholderText: "Enter"
                inputMethodHints: Qt.ImhDigitsOnly
            }
    }
}

/*##^##
Designer {
    D{i:0;formeditorColor:"#000000"}
}
##^##*/
