import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQml.Models
import QtQuick.Controls as Control
import Linphone
import EnumsToStringCpp 1.0
import UtilsCpp 1.0
import SettingsCpp 1.0
// =============================================================================

Item{
	id: mainItem
	property alias call: allDevices.currentCall
	property ConferenceGui conference: call && call.core.conference || null
	property var callState: call && call.core.state || undefined
	
	property ParticipantDeviceProxy participantDevices : ParticipantDeviceProxy {
			id: allDevices
			qmlName: "AS"
			onCountChanged: console.log("Device count changed : " +count)
			Component.onCompleted: console.log("Loaded : " +allDevices)
	}
	onCallStateChanged: if (callState === LinphoneEnums.CallState.End || callState === LinphoneEnums.CallState.Released) preview.visible = false
	RowLayout{
		anchors.fill: parent
		anchors.rightMargin: 10 * DefaultStyle.dp
		spacing: 16 * DefaultStyle.dp
		
		Sticker {
			id: activeSpeakerSticker
			previewEnabled: false
			Layout.fillWidth: true
			Layout.fillHeight: true
			call: mainItem.call
			participantDevice: mainItem.conference && mainItem.conference.core.activeSpeaker
			property var address: participantDevice && participantDevice.core.address
			videoEnabled: (participantDevice && participantDevice.core.videoEnabled) || (!participantDevice && call && call.core.remoteVideoEnabled)
			qmlName: 'AS'
			displayPresence: false
		}
		ListView{
			Layout.fillHeight: true
			Layout.preferredWidth: 300 * DefaultStyle.dp
			Layout.rightMargin: 10 * DefaultStyle.dp
			Layout.bottomMargin: 10 * DefaultStyle.dp
			visible: allDevices.count > 2
			//spacing: 15 * DefaultStyle.dp	// bugged? First item has twice margins
			model: allDevices
			snapMode: ListView.SnapOneItem
			clip: true
			delegate: Item{	// Spacing workaround
				visible: $modelData && mainItem.callState != LinphoneEnums.CallState.End  && mainItem.callState != LinphoneEnums.CallState.Released
										&& $modelData.core.address != activeSpeakerSticker.address || false
				height: visible ? (180 + 15) * DefaultStyle.dp : 0
				width: 300 * DefaultStyle.dp
				Sticker {
					previewEnabled: index == 0	// before anchors for priority initialization
					anchors.fill: parent
					anchors.bottomMargin: 15 * DefaultStyle.dp// Spacing
					qmlName: 'S_'+index
					visible: parent.visible
					participantDevice: $modelData
					displayAll: false
					displayPresence: false
					Component.onCompleted: console.log(qmlName + " is " +($modelData ? $modelData.core.address : "-"))
				}
			}
		}
	}
	Sticker {
		id: preview
		qmlName: 'P'
		previewEnabled: true
		visible: mainItem.call && allDevices.count <= 2
		onVisibleChanged: console.log(visible + " : " +allDevices.count)
		height: 180 * DefaultStyle.dp
		width: 300 * DefaultStyle.dp
		anchors.right: mainItem.right
		anchors.bottom: mainItem.bottom
		anchors.rightMargin: 20 * DefaultStyle.dp
		anchors.bottomMargin: 10 * DefaultStyle.dp
		//participantDevice: allDevices.me
		videoEnabled: preview.visible && mainItem.call && mainItem.call.core.localVideoEnabled
		onVideoEnabledChanged: console.log("P : " +videoEnabled + " / " +visible +" / " +mainItem.call)
		property AccountProxy accounts: AccountProxy{id: accountProxy}
		account: accountProxy.defaultAccount
		call: mainItem.call
		displayAll: false
		displayPresence: false

		MovableMouseArea {
			id: previewMouseArea
			anchors.fill: parent
			movableArea: mainItem
			margin: 10 * DefaultStyle.dp
			function resetPosition(){
				preview.anchors.right = mainItem.right
				preview.anchors.bottom = mainItem.bottom
				preview.anchors.rightMargin = previewMouseArea.margin
				preview.anchors.bottomMargin = previewMouseArea.margin
			}
			onVisibleChanged: if(!visible){
				resetPosition()
			}
			drag.target: preview
			onDraggingChanged: if(dragging) {
				preview.anchors.right = undefined
				preview.anchors.bottom = undefined
			}
			onRequestResetPosition: resetPosition()
		}
	}
}

