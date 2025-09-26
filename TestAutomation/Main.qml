import QtQuick 6.3
import QtQuick.Controls 6.3
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: root
    visible: true
    width: 1200
    height: 800
    title: qsTr("Dinamik Test Paneli")

    property int lastCompletedTestsCount: 0

    // Add this property to track if we should show the exit popup
    property bool showingExitPopup: false

    // Add this component for the exit popup
    Popup {
        id: exitPopup
        width: 300
        height: 150
        anchors.centerIn: parent
        modal: true
        closePolicy: Popup.NoAutoClose

        background: Rectangle {
            color: "#f5f5f5"
            radius: 10
            border.color: "#070757"
            border.width: 2
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            Text {
                text: "Uygulamadan çıkmak istediğinize emin misiniz?"
                font.pixelSize: 14
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                text: "Designed And Developed By S&D"
                font.pixelSize: 10
                font.italic: true
                color: "#666"
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                Layout.topMargin: 10
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                spacing: 20

                Button {
                    text: "Evet"
                    Layout.preferredWidth: 100
                    onClicked: Qt.quit()
                }

                Button {
                    text: "Hayır"
                    Layout.preferredWidth: 100
                    onClicked: {
                        showingExitPopup = false
                        exitPopup.close()
                    }
                }
            }
        }
    }

    // Modify the close event handler
    onClosing: function(close) {
        if (!showingExitPopup) {
            close.accepted = false
            showingExitPopup = true
            exitPopup.open()
        }
    }

    // Rest of your existing code remains the same...
    ListModel {
        id: tabModel
    }

    ListModel {
        id: homePageTestModel
    }

    ListModel {
        id: lastCompletedTestModel
    }

    function generateRandomSuccessRate() {
        return Math.random();
    }

    function generateRandomTestCases() {
        return Math.floor(Math.random() * (100 - 50 + 1)) + 50;
    }

    Component {
        id: circularProgressComponent
        Item {
            id: circularProgress
            property real progress: 0.75
            width: 120
            height: 120

            Canvas {
                id: canvas
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d");
                    var centerX = width / 2;
                    var centerY = height / 2;
                    var radius = Math.min(width, height) / 2 - 10;
                    var startAngle = -Math.PI / 2;
                    var endAngle = startAngle + circularProgress.progress * 2 * Math.PI;
                    ctx.clearRect(0, 0, width, height);

                    ctx.beginPath();
                    ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI, false);
                    ctx.lineWidth = 10;
                    ctx.strokeStyle = "#e0e0e0";
                    ctx.stroke();

                    if (circularProgress.progress > 0) {
                        ctx.beginPath();
                        ctx.arc(centerX, centerY, radius, startAngle, endAngle, false);
                        ctx.lineWidth = 10;
                        ctx.strokeStyle = "#81c784";
                        ctx.lineCap = "round";
                        ctx.stroke();
                    }
                }
            }

            onProgressChanged: canvas.requestPaint()

            Text {
                anchors.centerIn: parent
                text: Math.round(circularProgress.progress * 100) + "%"
                font.pixelSize: 28
                font.bold: true
                color: "#333"
            }
        }
    }

    Component {
        id: testPage
        Item {
            id: testPageRoot
            property string testTitle: "Başlıksız Test"
            property real successRate: 0.0
            property int ongoingTests: 0
            property int totalTestCases: 0
            property int passedTestCases: 0

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                Rectangle {
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width * 0.5
                    color: "white"
                    border.color: "#cccccc"
                    border.width: 1
                    radius: 10

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 0

                        Rectangle {
                            height: 30
                            Layout.fillWidth: true
                            color: "#070757"
                            radius: 10
                            z: 1
                            Text {
                                anchors.centerIn: parent
                                text: qsTr("Devam Eden Test Caseler")
                                color: "white"
                                font.bold: true
                                font.pixelSize: 14
                            }
                        }

                        ScrollView {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            clip: true

                            ListView {
                                width: parent.width
                                model: 56
                                delegate: Rectangle {
                                    height: 40
                                    width: parent.width
                                    border.color: "#ccc"
                                    border.width: 1
                                    color: "#fdfdfd"
                                    radius: 10
                                    clip: true
                                    Text {
                                        anchors.centerIn: parent
                                        text: qsTr("Test Case ") + (index + 1)
                                        color: "#333"
                                    }
                                }
                            }
                        }
                    }
                }

                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width * 0.5
                    spacing: 10

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: parent.height * 0.4
                        color: "white"
                        radius: 10
                        border.color: "#dddddd"
                        border.width: 1
                        anchors.margins: 10

                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 0
                            anchors.margins: 10

                            Rectangle {
                                height: 30
                                Layout.fillWidth: true
                                color: "#070757"
                                radius: 10
                                Text {
                                    anchors.centerIn: parent
                                    text: qsTr("Başarı Oranı")
                                    color: "white"
                                    font.bold: true
                                    font.pixelSize: 14
                                }
                            }

                            RowLayout {
                                Layout.fillWidth: true
                                anchors.centerIn: parent
                                spacing: 20

                                Loader {
                                    id: daireselProgress
                                    sourceComponent: circularProgressComponent
                                    onLoaded: {
                                        if (item) {
                                            item.progress = successRate
                                        }
                                    }
                                }

                                ColumnLayout {
                                    spacing: 6
                                    Text {
                                        text: qsTr("Genel Başarı: %") + Math.round(successRate * 100)
                                        font.pointSize: 14
                                        color: "#333"
                                    }

                                    Text {
                                        id: lastWeekText
                                        font.pointSize: 14
                                        text: {
                                            var lastWeekSuccessRate = Math.random()
                                            return qsTr("Son Başarı: %") + Math.round(lastWeekSuccessRate * 100)
                                        }
                                        color: {
                                            var lastWeekSuccessRate = Math.random()
                                            return lastWeekSuccessRate > 0.5 ? "#4CAF50" : "#F44336"
                                        }
                                    }

                                    Text {
                                        text: qsTr("Test Case Sayısı(∑): ") + passedTestCases + "/" + totalTestCases
                                        font.pointSize: 14
                                        color: "#333"
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "white"
                        radius: 10
                        border.color: "#dddddd"
                        border.width: 1

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 0

                            Rectangle {
                                id: recentTestsContainer
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                color: "white"
                                radius: 10
                                border.color: "#dddddd"
                                border.width: 1

                                ListModel {
                                    id: recentTestsModel
                                }

                                function generateAndSortTestData() {
                                    recentTestsModel.clear();
                                    var today = new Date();
                                    var year = today.getFullYear();
                                    var month = (today.getMonth() + 1).toString().padStart(2, '0');
                                    var day = today.getDate().toString().padStart(2, '0');
                                    var dateString = year + "/" + month + "/" + day;

                                    var unsortedTimes = [];
                                    for (var i = 0; i < 15; i++) {
                                        var randomHour = Math.floor(Math.random() * 24);
                                        var randomMinute = Math.floor(Math.random() * 60);
                                        unsortedTimes.push({ hour: randomHour, minute: randomMinute });
                                    }

                                    unsortedTimes.sort(function(a, b) {
                                        if (a.hour === b.hour) {
                                            return a.minute - b.minute;
                                        }
                                        return a.hour - b.hour;
                                    });

                                    for (var j = 0; j < unsortedTimes.length; j++) {
                                        var time = unsortedTimes[j];
                                        var formattedTime = time.hour.toString().padStart(2, '0') + ":" + time.minute.toString().padStart(2, '0');

                                        recentTestsModel.append({
                                            "testTitle": "🧪 Test " + (j + 1),
                                            "testDate": dateString,
                                            "testTime": formattedTime
                                        });
                                    }
                                }

                                Component.onCompleted: {
                                    generateAndSortTestData();
                                }

                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 10
                                    spacing: 0

                                    Rectangle {
                                        height: 30
                                        Layout.fillWidth: true
                                        color: "#070757"
                                        radius: 10
                                        Text {
                                            anchors.centerIn: parent
                                            text: qsTr("Son Yapılan Testler")
                                            color: "white"
                                            font.bold: true
                                            font.pixelSize: 14
                                        }
                                    }

                                    ScrollView {
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        clip: true

                                        ListView {
                                            model: recentTestsModel
                                            spacing: 5

                                            delegate: Rectangle {
                                                height: 40
                                                width: parent.width
                                                radius: 6
                                                color: "#f9f9f9"
                                                border.color: "#efefef"
                                                border.width: 1

                                                Text {
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    anchors.left: parent.left
                                                    anchors.leftMargin: 12
                                                    color: "#333"
                                                    font.pixelSize: 14
                                                    text: model.testTitle + " - " + model.testDate + " " + model.testTime
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            onSuccessRateChanged: {
                if (daireselProgress.item) {
                    daireselProgress.item.progress = successRate
                }
            }
        }
    }

    Component {
        id: homePageComponent
        Item {
            id: homePageRoot
            property real totalSuccessRate: 0.0
            property int totalTestCases: 0
            property int totalPassedTestCases: 0
            property string selectedTestTitle: ""
            property real selectedTestSuccessRate: 0.0
            property int selectedTestTotalCases: 0
            property int selectedTestPassedCases: 0

            function calculateTotalSuccessRate() {
                if (tabModel.count === 0) {
                    totalSuccessRate = 0.0
                    totalTestCases = 0
                    totalPassedTestCases = 0
                    return
                }
                var totalPassed = 0
                var totalCases = 0
                for (var i = 0; i < tabModel.count; ++i) {
                    totalPassed += tabModel.get(i).passedTestCases
                    totalCases += tabModel.get(i).totalTestCases
                }
                totalPassedTestCases = totalPassed
                totalTestCases = totalCases
                if (totalCases > 0) {
                    totalSuccessRate = totalPassed / totalCases
                } else {
                    totalSuccessRate = 0.0
                }
            }

            Connections {
                target: tabModel
                onCountChanged: homePageRoot.calculateTotalSuccessRate()
                onDataChanged: homePageRoot.calculateTotalSuccessRate()
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width * 0.5
                    spacing: 10

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: parent.height * 0.6
                        color: "white"
                        border.color: "#cccccc"
                        border.width: 1
                        radius: 10

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 0

                            Rectangle {
                                height: 30
                                Layout.fillWidth: true
                                color: "#070757"
                                radius: 10
                                Text {
                                    anchors.centerIn: parent
                                    text: qsTr("Devam Eden Test Prosedürleri")
                                    color: "white"
                                    font.bold: true
                                    font.pixelSize: 14
                                }
                            }

                            ScrollView {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                clip: true
                                ListView {
                                    id: ongoingTestsList
                                    width: parent.width
                                    model: homePageTestModel
                                    delegate: Rectangle {
                                        height: 40
                                        width: parent.width
                                        border.color: "#ccc"
                                        border.width: 1
                                        color: ongoingTestsList.currentIndex === index ? "#e0e0e0" : "#fdfdfd"
                                        radius: 10
                                        clip: true
                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: {
                                                ongoingTestsList.currentIndex = index;
                                                homePageRoot.selectedTestTitle = model.title;
                                                homePageRoot.selectedTestSuccessRate = model.successRate;
                                                homePageRoot.selectedTestTotalCases = model.totalTestCases;
                                                homePageRoot.selectedTestPassedCases = model.passedTestCases;
                                            }
                                        }
                                        RowLayout {
                                            anchors.fill: parent
                                            spacing: 5
                                            Text {
                                                Layout.fillWidth: true
                                                Layout.alignment: Qt.AlignVCenter
                                                leftPadding: 10
                                                text: model.title
                                                color: "#333"
                                                font.pixelSize: 14
                                            }
                                            Button {
                                                text: "✕"
                                                width: 30
                                                height: 30
                                                Layout.preferredWidth: 30
                                                Layout.alignment: Qt.AlignVCenter
                                                background: Rectangle { color: "transparent" }
                                                contentItem: Text {
                                                    text: parent.text
                                                    color: "#1c1b1b"
                                                    font.pixelSize: 20
                                                    anchors.centerIn: parent
                                                }
                                                onClicked: {
                                                    homePageTestModel.remove(index)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "white"
                        radius: 10
                        border.color: "#dddddd"
                        border.width: 1

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 0

                            Rectangle {
                                height: 30
                                Layout.fillWidth: true
                                color: "#070757"
                                radius: 10
                                Text {
                                    anchors.centerIn: parent
                                    text: homePageRoot.selectedTestTitle === "" ? qsTr("Seçili Test Başarı Oranı") : homePageRoot.selectedTestTitle
                                    color: "white"
                                    font.bold: true
                                    font.pixelSize: 14
                                }
                            }

                            RowLayout {
                                Layout.fillWidth: true
                                anchors.centerIn: parent
                                spacing: 20

                                Loader {
                                    id: selectedTestProgress
                                    sourceComponent: circularProgressComponent
                                    onLoaded: {
                                        if (item) {
                                            item.progress = homePageRoot.selectedTestSuccessRate
                                        }
                                    }
                                }
                                Connections {
                                    target: homePageRoot
                                    onSelectedTestSuccessRateChanged: {
                                        if (selectedTestProgress.item) {
                                            selectedTestProgress.item.progress = selectedTestSuccessRate
                                        }
                                    }
                                }

                                ColumnLayout {
                                    spacing: 6
                                    Text {
                                        text: qsTr("Başarı: %") + Math.round(homePageRoot.selectedTestSuccessRate * 100)
                                        font.pointSize: 14
                                        color: "#333"
                                    }
                                    Text {
                                        text: qsTr("Test Case: ") + homePageRoot.selectedTestPassedCases + "/" + homePageRoot.selectedTestTotalCases
                                        font.pointSize: 14
                                        color: "#555"
                                    }
                                }
                            }
                        }
                    }
                }

                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width * 0.5
                    spacing: 10

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: parent.height * 0.6
                        color: "white"
                        radius: 10
                        border.color: "#dddddd"
                        border.width: 1
                        anchors.margins: 10

                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 0
                            anchors.margins: 10

                            Rectangle {
                                height: 30
                                Layout.fillWidth: true
                                color: "#070757"
                                radius: 10
                                Text {
                                    anchors.centerIn: parent
                                    text: qsTr("Genel Başarı Oranı")
                                    color: "white"
                                    font.bold: true
                                    font.pixelSize: 14
                                }
                            }

                            RowLayout {
                                Layout.fillWidth: true
                                anchors.centerIn: parent
                                spacing: 20

                                Loader {
                                    id: daireselProgressHomePage
                                    sourceComponent: circularProgressComponent
                                    onLoaded: {
                                        if (item) {
                                            item.progress = homePageRoot.totalSuccessRate
                                        }
                                    }
                                }

                                ColumnLayout {
                                    spacing: 6
                                    Text {
                                        text: qsTr("Genel Başarı : %") + Math.round(homePageRoot.totalSuccessRate * 100)
                                        font.pointSize: 14
                                        color: "#333"
                                    }

                                    Text {
                                        text: qsTr("Test Case Sayısı(∑): ") + homePageRoot.totalPassedTestCases + "/" + homePageRoot.totalTestCases
                                        font.pointSize: 14
                                        color: "#333"
                                    }
                                }
                            }
                        }

                        Connections {
                            target: homePageRoot
                            onTotalSuccessRateChanged: {
                                if (daireselProgressHomePage.item) {
                                    daireselProgressHomePage.item.progress = totalSuccessRate
                                }
                            }
                            onTotalTestCasesChanged: calculateTotalSuccessRate()
                            onTotalPassedTestCasesChanged: calculateTotalSuccessRate()
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "transparent"

                        Image {
                            id: companyLogo
                            source: "file:///Users/Monster/Desktop/tei.jpg"
                            anchors.centerIn: parent
                            width: parent.width * 0.6
                            height: parent.height * 0.6
                            fillMode: Image.PreserveAspectFit
                        }
                    }
                }
            }
            onVisibleChanged: if (visible) calculateTotalSuccessRate()
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            Layout.fillWidth: true
            height: 25
            color: "#a5a5a8"
            z: 100
            RowLayout {
                anchors.fill: parent
                spacing: 10

                Repeater {
                    model: [qsTr("Ana Sayfa"), qsTr("Test Başlat"), qsTr("Canlı Test İzleme"), qsTr("Test Raporları"), qsTr("Ayarlar")]
                    delegate: Button {
                        id: menuButton
                        text: modelData
                        Layout.fillWidth: true
                        Layout.preferredWidth: parent.width / 5
                        hoverEnabled: true

                        background: Rectangle {
                            color: "transparent"
                        }
                        contentItem: Text {
                            anchors.centerIn: parent
                            text: modelData
                            color: "white"
                            font.pixelSize: 14
                        }

                        onClicked: {
                            if (index === 0) { // Ana Sayfa
                                tabBar.currentIndex = -1
                            } else if (index === 1) { // Test Başlat
                                startTestDialog.open()
                            } else if (index === 4) { // Ayarlar
                                settingsSubMenuPopup.open()
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.RightButton
                            hoverEnabled: true

                            onPressed: {
                                if (mouse.button === Qt.RightButton) {
                                    if (index === 0) homeSubMenuPopup.open()
                                }
                            }

                            onEntered: {
                                if (index === 0) {
                                    hoverTimer.stop()
                                    homeSubMenuPopup.open()
                                }
                            }

                            onExited: {
                                if (index === 0) {
                                    hoverTimer.start()
                                }
                            }
                        }

                        Popup {
                            id: homeSubMenuPopup
                            visible: false
                            x: menuButton.width - width
                            y: menuButton.height
                            width: 200
                            height: col.implicitHeight + 10
                            padding: 0
                            margins: 0
                            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

                            background: Rectangle {
                                color: "#070757"
                                radius: 5
                                border.color: "#a5a5a8"
                            }

                            contentItem: ColumnLayout {
                                id: col
                                spacing: 2

                                Button {
                                    text: "Tüm Sekmeleri Kapat"
                                    Layout.fillWidth: true
                                    background: Rectangle { color: "transparent" }
                                    contentItem: Text {
                                        text: parent.text;
                                        color: "white";
                                        horizontalAlignment: Text.AlignLeft;
                                        leftPadding: 10
                                    }
                                    onClicked: {
                                        tabModel.clear()
                                        homeSubMenuPopup.close()
                                    }
                                }
                                Button {
                                    text: "Dil Ayarları"
                                    Layout.fillWidth: true
                                    background: Rectangle { color: "transparent" }
                                    contentItem: Text {
                                        text: parent.text;
                                        color: "white";
                                        horizontalAlignment: Text.AlignLeft;
                                        leftPadding: 10
                                    }
                                    onClicked: {
                                        console.log("Dil ayarları açıldı")
                                        homeSubMenuPopup.close()
                                    }
                                }
                            }
                        }

                        Popup {
                            id: settingsSubMenuPopup
                            visible: false
                            x: menuButton.width - width
                            y: menuButton.height
                            width: 200
                            height: settingsCol.implicitHeight + 10
                            padding: 0
                            margins: 0
                            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

                            background: Rectangle {
                                color: "#070757"
                                radius: 5
                                border.color: "#a5a5a8"
                            }

                            contentItem: ColumnLayout {
                                id: settingsCol
                                spacing: 2

                                Button {
                                    text: "Kullanma Kılavuzu"
                                    Layout.fillWidth: true
                                    background: Rectangle { color: "transparent" }
                                    contentItem: Text {
                                        text: parent.text;
                                        color: "white";
                                        horizontalAlignment: Text.AlignLeft;
                                        leftPadding: 10
                                    }
                                    onClicked: {
                                        settingsSubMenuPopup.close()
                                        var component = Qt.createComponent("guide.qml");
                                        if (component.status === Component.Ready) {
                                            var guideWindow = component.createObject(root);
                                            guideWindow.show();
                                        }
                                    }
                                }

                                Button {
                                    text: "Yardım"
                                    Layout.fillWidth: true
                                    background: Rectangle { color: "transparent" }
                                    contentItem: Text {
                                        text: parent.text;
                                        color: "white";
                                        horizontalAlignment: Text.AlignLeft;
                                        leftPadding: 10
                                    }
                                    onClicked: {
                                        console.log("Yardım butonu tıklandı.")
                                        settingsSubMenuPopup.close()
                                    }
                                }
                            }
                        }

                        Timer {
                            id: hoverTimer
                            interval: 900
                            onTriggered: {
                                homeSubMenuPopup.close()
                                settingsSubMenuPopup.close()
                            }
                        }
                    }
                }
            }
        }

        TabBar {
            id: tabBar
            height: 40
            Layout.fillWidth: true
            background: Rectangle { color: "#070757" }

            Repeater {
                model: tabModel
                delegate: TabButton {
                    text: model.title
                    checked: index === tabBar.currentIndex
                    background: Rectangle { color: "#070757" }
                    contentItem: Row {
                        spacing: 2
                        anchors.verticalCenter: parent.verticalCenter
                        Text {
                            text: model.title
                            color: "white"
                            font.bold: parent.parent.checked
                        }
                        Button {
                            text: "✕"
                            font.pixelSize: 20
                            anchors.verticalCenter: parent.verticalCenter
                            width: 18
                            height: 18
                            onClicked: {
                                tabModel.remove(index)
                                if (tabBar.currentIndex >= tabModel.count) {
                                    tabBar.currentIndex = Math.max(0, tabModel.count - 1)
                                }
                            }
                            background: Rectangle { color: "transparent" }
                            palette.buttonText: "white"
                        }
                    }
                }
            }
        }

        StackLayout {
            id: pageStack
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: tabModel.count === 0 ? 0 : tabBar.currentIndex + 1

            Loader {
                id: homePageLoader
                sourceComponent: homePageComponent
            }

            Repeater {
                model: tabModel
                delegate: Loader {
                    sourceComponent: testPage
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    onLoaded: {
                        if (item) {
                            item.testTitle = model.title
                            item.successRate = model.successRate
                            item.ongoingTests = model.ongoingTests
                            item.totalTestCases = model.totalTestCases
                            item.passedTestCases = model.passedTestCases
                        }
                    }
                }
            }
        }
    }

    Popup {
        id: startTestDialog
        modal: true
        width: 500
        height: 620
        anchors.centerIn: parent
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        background: Rectangle {
            color: "#f5f5f5"
            radius: 10
            border.color: "#ccc"
        }

        onOpened: {
            testSelectionCombo.currentIndex = 0;
            testTypeCombo.currentIndex = 0;
            parametersTextArea.text = "";
            fileNameInput.text = "";
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15

            Text {
                text: "Yeni Test Başlat"
                font.pixelSize: 24
                font.bold: true
                color: "#333"
                Layout.alignment: Qt.AlignHCenter
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 5
                Text { text: "Test Seçimi:"; font.pixelSize: 14; font.bold: true }

                ComboBox {
                    id: testSelectionCombo
                    Layout.fillWidth: true
                    height: 40
                    model: ["Seçiniz", "PBİT", "CBİT", "KONFİGÜRASYON", "OPERASYONEL", "EMNİYET", "EYLEYİCİ", "CCP", "AYRIK SİNYAL", "SİNYAL", "BAŞLANGIÇ İŞLEMLERİ"]
                    currentIndex: 0
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 5
                Text { text: "Test Tipi Seçimi:"; font.pixelSize: 14; font.bold: true }
                ComboBox {
                    id: testTypeCombo
                    Layout.fillWidth: true
                    height: 40
                    model: ["Seçiniz", "Black Box","White Box", "Regression", "Unite", "Entegrasyon", "Non-functional", "Functional"]
                    currentIndex: 0
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 5
                Text { text: "Test Parametreleri (JSON veya Form):"; font.pixelSize: 14; font.bold: true }
                TextArea {
                    id: parametersTextArea
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    placeholderText: "Örnek: { \"param1\": \"deger1\", \"param2\": 123 }"
                    font.pixelSize: 14
                    background: Rectangle {
                        color: "#fff"
                        radius: 5
                        border.color: "#ccc"
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 10
                Layout.alignment: Qt.AlignHCenter

                Button {
                    text: "Kaydet"
                    Layout.preferredWidth: 150
                    height: 40
                    background: Rectangle {
                        color: "#293133"
                        radius: 5
                    }
                    font.pixelSize: 14
                    palette.buttonText: "white"
                    onClicked: {
                        console.log("Kaydet butonuna tıklandı.");
                    }
                }

                Button {
                    text: "Tümünü Kaydet"
                    Layout.preferredWidth: 150
                    height: 40
                    background: Rectangle {
                        color: "#293133"
                        radius: 5
                    }
                    font.pixelSize: 14
                    palette.buttonText: "white"
                    onClicked: {
                        console.log("Tümünü Kaydet butonuna tıklandı.");
                    }
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 5
                Text { text: "Yüklenen Dosya:"; font.pixelSize: 14; font.bold: true }
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 10

                    TextField {
                        id: fileNameInput
                        Layout.fillWidth: true
                        placeholderText: "Dosya adı burada görünecek"
                        font.pixelSize: 14
                        readOnly: true
                        height: 40
                    }

                    Button {
                        id: uploadButton
                        text: "Dosya Yükle"
                        Layout.preferredWidth: 120
                        height: 40
                        background: Rectangle {
                            color: "#1c1b1b"
                            radius: 5
                        }
                        font.pixelSize: 14
                        palette.buttonText: "white"
                        onClicked: {
                            if (testSelectionCombo.currentIndex > 0) {
                                var selectedTest = testSelectionCombo.currentText.replace(/\s/g, "_");
                                fileNameInput.text = selectedTest + "_test_script.hex";
                                console.log("Dosya adı oluşturuldu: " + fileNameInput.text);
                            } else {
                                console.log("Lütfen önce bir test seçin.");
                            }
                        }
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                Button {
                    id: cancelButton
                    Layout.fillWidth: true
                    text: "İptal Et"
                    height: 40
                    background: Rectangle {
                        color: "#E30A17"
                        radius: 5
                    }
                    font.pixelSize: 16
                    palette.buttonText: "white"
                    onClicked: {
                        startTestDialog.close();
                    }
                }

                Button {
                    id: startButton
                    Layout.fillWidth: true
                    text: "Başlat"
                    height: 40
                    background: Rectangle {
                        color: "#4da34d"
                        radius: 5
                    }
                    font.pixelSize: 16
                    palette.buttonText: "white"
                    onClicked: {
                        if (fileNameInput.text.trim() !== "" && testSelectionCombo.currentIndex > 0 && testTypeCombo.currentIndex > 0) {
                            var newSuccessRate = Math.random();
                            var newOngoingTests = Math.floor(Math.random() * 100);
                            var totalCases = generateRandomTestCases();

                            tabModel.append({
                                title: testSelectionCombo.currentText,
                                successRate: newSuccessRate,
                                ongoingTests: newOngoingTests,
                                totalTestCases: totalCases,
                                passedTestCases: Math.floor(totalCases * newSuccessRate)
                            });

                            homePageTestModel.append({
                                title: testSelectionCombo.currentText + " - " + fileNameInput.text,
                                successRate: newSuccessRate,
                                ongoingTests: newOngoingTests,
                                totalTestCases: totalCases,
                                passedTestCases: Math.floor(totalCases * newSuccessRate)
                            });

                            tabBar.currentIndex = tabModel.count - 1;
                            startTestDialog.close();
                        } else {
                            console.log("Dosya adı ve test seçimleri boş bırakılamaz.");
                        }
                    }
                }
            }
        }
    }
}
