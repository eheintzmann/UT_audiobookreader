/*
 * Copyright (C) 2024  fsjl
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * audiobookreader is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Lomiri.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import Example 1.0

import QtMultimedia 5.11

import Lomiri.Content 1.0


MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'audiobookreader.fsjl'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    property var bookmark 
    property var filePicker: lomiriFilePicker.createObject(root)

    readonly property Component lomiriFilePicker :
    Qt.createComponent("qrc:/LomiriFilePicker.qml",
                        Component.PreferSynchronous);

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('AudioBookReader')
        }
        Audio{
            id: audio

        }
        ListModel{
            id: audiobooksmodel
            ListElement{
                title: "chapter1"
                audioSource: "https://samples-files.com/samples/Audio/ogg/sample-file-1.ogg"
                
            }
            ListElement{
                title: "chapter2"
                audioSource: "https://samples-files.com/samples/Audio/ogg/sample-file-2.ogg"
            }
        }
        ListView{
            model: audiobooksmodel
            anchors{
                fill: parent
                topMargin: header.height
            }
            delegate: ListItem{
                Label{
                    text: title

                }
                onClicked:{
                    audio.source = audioSource
                    audio.play()
                }
            }
            
        }

        ColumnLayout {
            spacing: units.gu(2)
            anchors {
                margins: units.gu(2)
                top: header.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            Item {
                Layout.fillHeight: true
            }

            Label {
                id: label
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('Press the button below and check the logs!')
            }

            Button {
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('Bookmark')
                onClicked: {
                    root.bookmark = audio.position
                    console.log("test")
                    console.log(root.bookmark)
                    audio.stop()
                }
            }

            Button {
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('Play Bookmark')
                onClicked: {
                    audio.seek(root.bookmark)
                    audio.play()
                }
            }
            Button {
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('Open File')
                onClicked: {
                    filePicker.open()
                }
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}
