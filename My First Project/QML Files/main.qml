import QtQuick 2.6
import QtQml 2.12
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import QtQuick.Controls.Universal 2.0
import QtQuick.Controls.Imagine 2.3
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Timeline 1.0
import QtCharts 2.3
import QtQuick.Controls.Material 2.0
import QtQuick.VirtualKeyboard 2.12


ApplicationWindow{
    id:main
    width:800
    height:480
    color:"#191b17"
    property alias rect: rectangle2
    property alias rectHeight: rectangle2.height
    property real maxxval: serial_data.wValue.y
    property double vallMax: 0
    property double vallMin: 0
    property var i: 0
    property var j : 0
    property var t : new Array (10)
    property string greenC : "#8BC34A"
    property string greyC : "#8c8080"
    property string blackC: "#000000"
    property string password: ""
    title: qsTr("NorthwatMS")
    visible: true

    Shortcut{
        sequence:"Ctrl+Q"
        onActivated:Qt.quit()
    }
    Rectangle{
        id: lockScreen
        anchors.fill: parent
        visible: true
        color:"#191b17"
        TextField{
            id: passwrd
            x: 300
            y: 51
            font.bold: true
            font.family: "Arial"
            placeholderText: "Password"
            font.pixelSize: 18
            inputMethodHints: Qt.ImhDigitsOnly
            echoMode:TextInput.Password
            background: Rectangle{
                implicitHeight: 40
                implicitWidth: 200
                color: passwrd.enabled ? "transparent" : "#353637"
                border.color: passwrd.enabled ? "#21be2b" : "transparent"
            }
        }
        Label{
            id:check1
            x: 370
            y: 99
            text: "Incorrect!!"
            font.pixelSize: 12
            font.bold: true
            font.family: "Arial"
            color: "red"
            visible: false
        }

        InputPanel {
            id: inputPanel
            z: 89
            y: active ? parent.height - height : parent.height
            anchors.left: parent.left
            anchors.right: parent.right
        }
        Button{
            id:ok
            text: "ENTER"
            font.bold: true
            font.family: "Arial"
            font.pixelSize: 20
            height: 50
            width : 200
            x : 300
            y : 125
            palette.button: greyC
            onClicked: {
                password = passwrd.text
                check()
            }
        }
    }


    function check(){
        if(password === serial_data.password){
            lockScreen.visible = false
            swipeView.visible = true
            row.visible = true
            stack1.enabled = true
        }else{
            check1.visible = true
            lockScreen.visible = true
            swipeView.visible = false
            row.visible = false
            stack1.enabled =false
        }
    }

    SwipeView {
        id: swipeView
        width: 800
        height: 363
        currentIndex: 0
        onCurrentIndexChanged:curindex()
        visible: false

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
                    x: 615
                    y: 16
                    width: 60
                    height: 290
                    spacing: 10

                    RoundButton {
                        id: forwardgear
                        radius: 10
                        text: "F"
                        font.capitalization: Font.AllUppercase
                        font.bold: true
                        font.pixelSize: 25
                        font.family: "Arial"
                        width: parent.width
                        height:90
                        checkable: false
                        checked : false
                        enabled :true
                        background: Rectangle{
                            id:forwardGear
                            radius:10
                            anchors.fill:parent
                            color: greyC                       }
                        onClicked: {
                            serial_data.Gear = "110"
                            forwardGear.color = Material.color(Material.Orange)
                            neutralGear.color = greyC
                            reverseGear.color = greyC
                        }
                    }
                        RoundButton {
                            id: neutralgear
                            radius:10
                            text: "N"
                            focusPolicy: Qt.TabFocus
                            font.capitalization: Font.AllUppercase
                            font.bold: true
                            font.pixelSize: 25
                            font.family: "Arial"
                            width:parent.width
                            height:90
                            checked:false
                            enabled: true
                            background: Rectangle{
                                id:neutralGear
                                radius: 10
                                anchors.fill: parent
                                color: greyC
                            }
                            onClicked: {
                                serial_data.Gear = "100";
                                forwardGear.color = greyC
                                neutralGear.color = Material.color(Material.Orange)
                                reverseGear.color = greyC
                            }
                        }

                            RoundButton {
                                id: reversegear
                                radius: 10
                                text: "R"
                                focusPolicy: Qt.TabFocus
                                font.capitalization: Font.AllUppercase
                                font.bold: true
                                font.pixelSize: 25
                                font.family: "Arial"
                                width: parent.width
                                height: 90
                                checkable: false
                                Material.elevation: 0
                                enabled: true
                                background: Rectangle{
                                    id:reverseGear
                                    radius: 10
                                    anchors.fill: parent
                                    color:greyC
                                }
                                onClicked: {
                                    serial_data.Gear = "101"
                                    forwardGear.color = greyC
                                    neutralGear.color = greyC
                                    reverseGear.color = Material.color(Material.Orange)
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
                                    x: 559
                                    y: 0
                                    width: 13
                                    height: 321
                                    anchors.right: parent.right
                                    anchors.rightMargin: 144
                                }


                                Text {
                                    id: element
                                    x: 84
                                    y: 273
                                    width: 55
                                    height: 28
                                    color: "#a0a0a0"
                                    text: serial_data.cal_value + "%"
                                    textFormat: Text.AutoText
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Arial"
                                    font.bold: true
                                    fontSizeMode: Text.FixedSize
                                    font.pixelSize: 20
                                }
                                Rectangle {
                                    id: rectangle2
                                    x: 51
                                    y: 245 - serial_data.cal_value*2
                                    width: 120
                                    height:serial_data.cal_value*2
                                    color: "#b3c34a"
                                    radius: 7
                                    states: [
                                        State {
                                            name: "Full"
                                            when:rectangle2.height <= 200 && rectangle2.height >= 150
                                            PropertyChanges {
                                                target: rectangle2
                                                color:Material.color(Material.Green)
                                            }
                                        },
                                        State {
                                            name: "Quarter"
                                            when :rectangle2.height <= 149 && rectangle2.height >= 100
                                            PropertyChanges {
                                                target: rectangle2
                                                color:Material.color(Material.Yellow)
                                            }
                                        },
                                        State {
                                            name: "Half"
                                            when:rectangle2.height <= 99 && rectangle2.height >= 50
                                            PropertyChanges {
                                                target: rectangle2
                                                color: Material.color(Material.Orange)
                                            }
                                        },
                                        State {
                                            name: "name"
                                            when:rectangle2.height <= 49 && rectangle2.height >= 0
                                            PropertyChanges {
                                                target: rectangle2
                                                color:Material.color(Material.Red)
                                            }
                                        }
                                    ]
                                }

                                Text {
                                    id: element7
                                    x: 60
                                    y: 302
                                    width: 102
                                    height: 20
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.bold: true
                                    font.family: "Arial"
                                    font.pixelSize: 18
                                    color:"#a0a0a0"
                                    text: "12kWh"
                                }

                                Column {
                                    id: column2
                                    x: 247
                                    y: 54
                                    width: 306
                                    height: 244
                                    spacing: 20

                                    Text {
                                        id: element3
                                        text: qsTr("Current Consumption : " + serial_data.current_Data)
                                        font.family: "Arial"
                                        fontSizeMode: Text.Fit
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        font.pixelSize: 20
                                        color:"#a0a0a0"
                                    }

                                    Text {
                                        id: element4
                                        text: qsTr("Coulomb Count : " + serial_data.data)
                                        font.family: "Arial"
                                        fontSizeMode: Text.Fit
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 20
                                        color:"#a0a0a0"
                                    }
                                }
                            }
            Timer{
                id:timer
                repeat: true
                interval: 250
                running: true
                onTriggered: {
//                    gearchange1()
                    gearchange()
                    modes()

                }
            }

                        }

                        Item {
                            id:secondpg
                            width:swipeView.width
                            height:swipeView.height
                            Drawer{
                                id:stack1
                                width: secondpg.width
                                height: main.height
                                edge:Qt.TopEdge
                                interactive: true
                                enabled: false
                                background: Rectangle{
                                    anchors.fill: parent
                                    color: Material.color(Material.Grey, Material.Shade600)
                                }
                                Item{
                                    anchors.fill: parent
                                    Label{
                                        id:labl1
                                        x:20
                                        y:33
                                        text: "Battery Capacity"
                                        font.bold: true
                                        font.family: "Arial"
                                        font.pixelSize: 20
                                        color: "#191b17"
                                    }

                                    TextField{
                                        id: counter
                                        x: 200
                                        y: 20
                                        font.pixelSize: 20
                                        font.family: "Arial"
                                        placeholderText: serial_data.show_Cal
                                        inputMethodHints: Qt.ImhDigitsOnly
                                        background: Rectangle{
                                            implicitHeight: 50
                                            implicitWidth: 180
                                            color: counter.enabled ? "transparent" : "#353637"
                                            border.color: counter.enabled ? "#191b17" : "transparent"
                                        }
                                    }
                                    InputPanel{
                                        id:inputPanel1
                                        z: 89
                                        y: 220
                                        height:270
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        visible: true
                                    }
                                    RoundButton{
                                        id:coulChange
                                        x : 450
                                        y : 20
                                        width: 180
                                        height: 50
                                        radius: 7
                                        background: Rectangle{
                                            id:backg
                                            radius: 7
                                            Text{
                                                anchors.centerIn: parent
                                                text: "RESET"
                                                font.family: "Arial"
                                                font.bold: true
                                                color: "Grey"
                                                font.pixelSize: 25
                                            }
                                            anchors.fill: parent
                                            color: "#191b17"
                                        }
                                        onClicked: {
                                            serial_data.callibrationn = counter.text
                                            counter.text = ""
                                        }
                                        onPressed: {
                                            backg.color = Material.color(Material.Green)
                                        }
                                        onReleased: {
                                            backg.color = "#191b17"
                                        }
                                    }
                                    Label{
                                        id:labl2
                                        x:20
                                        y:113
                                        text: "Paasword"
                                        font.bold: true
                                        font.family: "Arial"
                                        font.pixelSize: 20
                                        color: "#191b17"
                                    }
                                    TextField{
                                        id: resetPasswrd
                                        x: 200
                                        y: 100
                                        font.pixelSize: 20
                                        font.family: "Arial"                                 
                                        placeholderText: "Enter Password"
                                        inputMethodHints: Qt.ImhDigitsOnly
                                        echoMode:TextField.Password
                                        background: Rectangle{
                                            implicitHeight: 50
                                            implicitWidth: 180
                                            color: counter.enabled ? "transparent" : "#353637"
                                            border.color: counter.enabled ? "#191b17" : "transparent"
                                        }
                                    }
                                    InputPanel{
                                        id:inputPanel2
                                        z: 89
                                        y:180
                                        height:300
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        visible: true
                                    }
                                    RoundButton{
                                        id:resetPass
                                        x : 450
                                        y : 100
                                        width: 180
                                        height: 50
                                        background: Rectangle{
                                            id:backg1
                                            Text{
                                                anchors.centerIn: parent
                                                text: "RESET"
                                                font.family: "Arial"
                                                font.bold: true
                                                color: "Grey"
                                                font.pixelSize: 25
                                            }
                                            radius: 7
                                            anchors.fill: parent
                                            color: "#191b17"
                                        }
                                        onClicked: {
                                            serial_data.password = resetPasswrd.text
                                            resetPasswrd.text = ""
                                        }
                                        onPressed: {
                                            backg1.color = Material.color(Material.Green)
                                        }
                                        onReleased: {
                                            backg1.color = "#191b17"
                                            txt.visible = true
                                        }
                                    }
                                    Label{
                                        id:txt
                                        x : 200
                                        y : 175
                                        text: "Password has been Changed!!"
                                        font.pixelSize: 16
                                        font.bold: true
                                        font.family: "Arial"
                                        color: "Black"
                                        visible: false
                                    }
                                }
                            }
//                            Frame {
//                                id: frame1
//                                y: 30
//                                height: 345
//                                anchors.left: parent.left
//                                anchors.leftMargin: 30
//                                anchors.right: parent.right
//                                anchors.rightMargin: 30
                                Connections {
                                    target: serial_data
                                    onWValueChanged:{
                                        if(lineSeries1.count > 100)
                                            lineSeries1.remove(0);
                                        lineSeries1.append(serial_data.wValue.x, serial_data.wValue.y)
                                        axisX.min = lineSeries1.at(0).x
                                        axisX.max = lineSeries1.at(lineSeries1.count-1).x;
                                    }
                                }

                                Timer{
                                    id:plott
                                    repeat: true
                                    running: true
                                    interval: 250
                                    onTriggered: {
                                        t[j] =(maxxval)
                                        if(j == 10)
                                            j =0
                                        else
                                            j = j+1

                                        vallMax = 0
                                        vallMin = 0
                                        for( i = 0; i < 10 ; i++){
                                            if(t[i] > vallMax){
                                                vallMax = t[i]
                                            }
                                            if(t[i] < vallMin){
                                                vallMin = t[i]
                                            }
                                        }
                                    }
                                }

                                ChartView {
                                    id: chartView
                                    width: 300
                                    height: 200
                                    anchors.bottomMargin: -21
                                    anchors.leftMargin: -20
                                    anchors.rightMargin: -20
                                    anchors.topMargin: 5
                                    anchors.fill: parent
                                    animationOptions: ChartView.NoAnimation
                                    antialiasing: true
                                    backgroundColor: "#191b17"
                                    title: "CURRENT COMSUMPTION"
                                    titleColor: greyC
                                    titleFont:Qt.font({

                                                          bold : true,
                                                          pixelSize: 18
                                                      })
                                    ValueAxis {
                                        id: axisY1
                                        min: vallMin -3
                                        max: vallMax + 3
                                        gridVisible: false
                                        color:greyC
                                        labelsColor:greyC
                                        labelFormat: "%.0f"
                                        labelsFont: Qt.font({pixelSize: 18})
                                        tickCount: 5
                                    }
                                    ValueAxis {
                                        id: axisX
                                        min: 0
                                        max: 50
                                        gridVisible: false
                                        visible: true
                                        color: greyC
                                        labelsColor: greyC
                                        labelFormat: "%.0f"
                                        labelsFont: Qt.font({pixelSize: 18})
                                        tickCount: 5
                                    }

                                    SplineSeries {
                                        id: lineSeries1
                                        color:greenC
                                        capStyle: Qt.RoundCap
                                        axisX: axisX
                                        axisY: axisY1
                                    }
                                }
//                            }
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

                                Image {
                                    id: image
                                    height: 480
                                    anchors.rightMargin: -38
                                    anchors.bottomMargin: -41
                                    anchors.leftMargin: -38
                                    anchors.topMargin: -104
                                    anchors.fill: parent
                                    fillMode: Image.PreserveAspectFit
                                    source: "file:/home/pi/car.png"

                                    Text {
                                        id: element10
                                        x: 542
                                        y: 360
                                        width: 180
                                        height: 34
                                        color: "#d0c4c4"
                                        text: modes()
                                        font.weight: Font.Medium
                                        font.bold: true
                                        font.family: "Tahoma"
                                        font.pixelSize: 30
                                    }
                                }
                            }
                        }
                    }

                    Row {
                        id: row
                        y: 381
                        height: 90
                        anchors.right: parent.right
                        anchors.rightMargin: 30
                        anchors.left: parent.left
                        anchors.leftMargin: 30
                        spacing: 10
                        padding: 0
                        visible: false

                        RoundButton {
                            id: drivebtn
                            radius:10
                            width: 240
                            height:row.height
                            onClicked: {
                                swipeView.setCurrentIndex(0)
                                drive.color = greenC
                                battery.color = greyC
                                motor.color = greyC
                            }
                            background: Rectangle{
                                id:drive
                                radius:10
                                anchors.fill: parent
                                color: greenC
                            }
                            layer.smooth: false
                            flat: false
                            highlighted: false
                            font.weight: Font.Normal
                            focusPolicy: Qt.TabFocus
                            font.capitalization: Font.AllUppercase
                            font.pixelSize: 15
                            font.bold: true
                            font.family: "Arial"

                            Image {
                                id: image4
                                x: 70
                                y: 10
                                width: 100
                                height: 80
                                source: "File:/home/pi/car(1).png"
                                fillMode: Image.PreserveAspectFit
                            }
                        }

                        RoundButton {
                            id: batterybtn
                            radius:10
                            focusPolicy: Qt.TabFocus
                            font.capitalization: Font.AllUppercase
                            font.bold: true
                            font.family: "Arial"
                            font.pixelSize: 15
                            width: 240
                            height: row.height
                            onClicked: {
                                swipeView.setCurrentIndex(1)
                                battery.color = greenC
                                motor.color = greyC
                                drive.color = greyC
                            }
                            background: Rectangle{
                                id:battery
                                radius:10
                                anchors.fill: parent
                                color:greyC
                            }

                            Image {
                                id: image2
                                x: 70
                                y: 14
                                width: 100
                                height: 62
                                fillMode: Image.PreserveAspectFit
                                source: "File:/home/pi/charger(2).png"
                            }
                        }

                        RoundButton {
                            id: motorbtn
                            radius:10
                            focusPolicy: Qt.TabFocus
                            font.capitalization: Font.AllUppercase
                            font.bold: true
                            font.pixelSize: 15
                            font.family: "Arial"
                            width: 240
                            height:row.height
                            onClicked: {
                                swipeView.setCurrentIndex(2)
                                motor.color = greenC
                                battery.color= greyC
                                drive.color = greyC
                            }
                            background: Rectangle{
                                id:motor
                                radius:10
                                anchors.fill: parent
                                color: greyC
                            }

                            Image {
                                id: image1
                                x: 70
                                y: 5
                                width: 100
                                height: 80
                                source: "File:/home/pi/engine.png"
                                fillMode: Image.PreserveAspectFit
                            }
                        }
                    }
                    function curindex(){
                        if(swipeView.currentIndex===0){
                            drive.color = greenC
                            battery.color = greyC
                            motor.color = greyC
                        }
                        else if(swipeView.currentIndex===1){
                            battery.color = greenC
                            motor.color = greyC
                            drive.color = greyC
                        }
                        else if(swipeView.currentIndex===2){
                            motor.color = greenC
                            drive.color = greyC
                            battery.color = greyC
                        }
                    }

//                    function gearchange1(){
//                        if(serial_data.Gear_C === '100'){
//                            reverseGear.color = greyC
//                            forwardGear.color = greyC
//                            neutralGear.color = greenC
//                        }
//                        else if(serial_data.Gear_C === '110'){
//                            reverseGear.color = greyC
//                            forwardGear.color = greenC
//                            neutralGear.color = greyC
//                        }
//                        else if(serial_data.Gear_C === '101'){
//                            reverseGear.color = greenC
//                            forwardGear.color = greyC
//                            neutralGear.color = greyC
//                        }
//                        else if(serial_data.Gear_C === '000'){
//                            reverseGear.enabled = false
//                            forwardGear.enabled = false
//                            neutralGear.enabled = false
//                        }
//                    }

                    function gearchange(){
                        var f = forwardGear.color
                        var r = reverseGear.color
                        var n = neutralGear.color
                            if(serial_data.Gear_C === '100'){
                                if(r === greenC){
                                    reverseGear.color = greyC
                                }
                                if(f === greenC){
                                    forwardGear.color = greyC
                                }
                                if(n === Material.color(Material.Orange) || blackC){
                                    neutralGear.color = greenC
                                }
                            }
                            else if(serial_data.Gear_C === '110'){
                                if(r === greenC){
                                    reverseGear.color = greyC
                                }
                                if(f === Material.color(Material.Orange) || blackC){
                                    forwardGear.color = greenC
                                }
                                if(n === greenC){
                                    neutralGear.color = greyC
                                }
                            }
                            else if(serial_data.Gear_C === '101'){
                                if(r === Material.color(Material.Orange) || blackC){
                                    reverseGear.color = greenC
                                }
                                if(f === greenC){
                                    forwardGear.color = greyC
                                }
                                if(n === greenC){
                                    neutralGear.color = greyC
                                }
                            }
                            else if(serial_data.Gear_C === '000'){
                                reverseGear.color = blackC
                                neutralGear.color = blackC
                                forwardGear.color = blackC
                                reversegear.enabled = false
                                forwardgear.enabled = false
                                neutralgear.enabled = false
                            }
                            else{
                                reverseGear.color=greyC
                                neutralGear.color=greyC
                                forwardGear.color=greyC
                            }
                    }

                    function modes(){
                        if(serial_data.Gear_C === '100'){
                            element10.text = "Neutral Mode"
                        }
                        else if(serial_data.Gear_C === '110'){
                            element10.text = "Drive Mode"
                        }
                        else if(serial_data.Gear_C === '101'){
                            element10.text = "Reverse Mode"
                        }
                        else{
                            element10.text = ""
                        }
                    }
                }
