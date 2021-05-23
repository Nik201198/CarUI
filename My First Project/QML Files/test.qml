import QtQuick 2.6
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import QtQuick.Controls.Universal 2.0
import QtQuick.Controls.Imagine 2.3
import QtQuick.Controls 2.12
import QtQuick.Timeline 1.0


Window{
    id:main
    width:800
    height:480
    color:"#d3d7cf"
    title: qsTr("NorthwatMS")
    visible: true
    Shortcut{
        sequence:"Ctrl+X"
        onActivated: Qt.quit()
    }

    SwipeView {
        id: swipeView
        width: 800
        height: 375
        currentIndex: 0

        Item {
            id: firstpg
            width:swipeView.width
            height:swipeView.height
            Frame {
                id: frame0
                y: 30
                height: 345
                anchors.left: parent.left
                anchors.leftMargin: 30
                anchors.right: parent.right
                anchors.rightMargin: 30

                Column {
                    id: column
                    x: 579
                    y: 16
                    width: 60
                    height: 290
                    spacing: 10

                    RoundButton {
                        id: forwardgear
                        radius: 10
                        text: "F"
                        focusPolicy: Qt.TabFocus
                        font.capitalization: Font.AllUppercase
                        font.bold: true
                        font.pixelSize: 15
                        font.family: "Arial"
                        width: parent.width
                        height:90
                        background: Rectangle{
                            radius:10
                            anchors.fill:parent
                            color:"#9E9E9E"
                        }

                    }

                    RoundButton {
                        id: neutralgear
                        radius:10
                        text: "N"
                        focusPolicy: Qt.TabFocus
                        font.capitalization: Font.AllUppercase
                        font.bold: true
                        font.pixelSize: 15
                        font.family: "Arial"
                        width:parent.width
                        height:90
                        background: Rectangle{
                            radius: 10
                            anchors.fill: parent
                            color:"#8BC34A"
                        }
                    }

                    RoundButton {
                        id: reversegear
                        radius: 10
                        text: "R"
                        focusPolicy: Qt.TabFocus
                        font.capitalization: Font.AllUppercase
                        font.bold: true
                        font.pixelSize: 15
                        font.family: "Arial"
                        width: parent.width
                        height: 90
                        background: Rectangle{
                            radius: 10
                            anchors.fill: parent
                            color: "#9E9E9E"
                        }
                    }
                }

                ToolSeparator {
                    id: toolSeparator
                    y: 0
                    width: 13
                    height: 321
                    anchors.left: parent.left
                    anchors.leftMargin: 228
                }

                ToolSeparator {
                    id: toolSeparator1
                    x: 477
                    y: 0
                    width: 13
                    height: 321
                    anchors.right: parent.right
                    anchors.rightMargin: 228
                }
            }
        }

        Item {
            id:secondpg
            width:swipeView.width
            height:swipeView.height
            Frame {
                id: frame1
                y: 30
                height: 345
                anchors.left: parent.left
                anchors.leftMargin: 30
                anchors.right: parent.right
                anchors.rightMargin: 30

                ToolSeparator {
                    id: toolSeparator2
                    x: 326
                    y: 0
                    width: 13
                    height: 321
                }
            }
        }

        Item {
            id:thirdpg
            width:swipeView.width
            height:swipeView.height
            Frame {
                id: frame
                y: 30
                height: 345
                anchors.left: parent.left
                anchors.leftMargin: 30
                anchors.right: parent.right
                anchors.rightMargin: 30
            }
        }
    }

    TabBar {
        id: tabBar
        x: 30
        y: 399
        width: 740
        height: 70
        position: TabBar.Footer
        background: Rectangle{
            anchors.fill:parent
            color:main.color
        }

        TabButton {
            id: tabButton
            RadialGradient: true
            width: 245
            height: parent.height
            visible: true
            text: qsTr("DRIVE")
            background: Rectangle{
                id: drive
                anchors.fill:parent
                color:"#9E9E9E"
            }
            onClicked: swipeView.setCurrentIndex(0)
        }

        TabButton {
            id: tabButton1
            width: 245
            height: parent.height
            text: qsTr("BATTERY")
            background: Rectangle{
                id: battery
                anchors.fill: parent
                color:"#9E9E9E"
            }
            onClicked:swipeView.setCurrentIndex(1)
        }

        TabButton {
            id: tabButton2
            width: 245
            height: parent.height
            text: qsTr("MOTOR")
            background: Rectangle{
                id: motor
                anchors.fill: parent
                color:"#9E9E9E"
            }
            onClicked: swipeView.setCurrentIndex(2)
        }
    }
}
