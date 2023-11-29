import QtQuick 2.15
import QtQuick.Layouts 1.0
import QtQuick.Controls as Control
import Linphone
import UtilsCpp 1.0

// Snippet
Window{
	id: mainItem
	height: 800
	width: 1000
	visible: true
	ColumnLayout{
		anchors.fill: parent
		RowLayout{
			FriendGui{
				id: contact
			}
			TextInput{
				placeholderText: 'Name'
				initialText: contact.core.name
				onTextChanged: contact.core.name = text 
			}
			TextInput{
				placeholderText: 'Address'
				initialText: contact.core.address
				onTextChanged: contact.core.address = text
			}
			Button {
				text: 'Create'
				onClicked: {
					contact.core.save()
				}
			}
			Text{
				text: 'IsSaved:'+contact.core.isSaved
			}
		}
		ListView{
			id: friends
			Layout.fillHeight: true
			Layout.fillWidth: true
			
			model: MagicSearchProxy{
				id: search
				searchText: ''
			}
			delegate: Rectangle{
				height: 50
				width: friends.width
				RowLayout{
					anchors.fill: parent
					Text{
						text: modelData.core.presenceTimestamp + " == " +modelData.core.consolidatedPresence + " / "
					}
					Button {
						text: 'X'
						onClicked: {
							modelData.core.remove()
						}
					}
					Text{
						text: modelData.core.address
					}
					TextInput{
						initialText: modelData.core.address
						onTextChanged: if(modelData.core.address != text){
								modelData.core.address = text
								resetText()
							 }
					}
					Text{
						text: 'IsSaved:'+modelData.core.isSaved
					}
					Button {
						text: 'Revert'
						onClicked: {
							modelData.core.undo()
						}
					}
					Button {
						text: 'Save'
						onClicked: {
							modelData.core.save()
						}
					}
				}
			}
		}
		Button {
			text: 'Get'
			Layout.rightMargin: 20
			onClicked: {
				search.searchText = '*'
			}
		}
	}
	
}
