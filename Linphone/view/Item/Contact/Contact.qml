import QtQuick
import QtQuick.Effects

import QtQuick.Layouts


import Linphone
import UtilsCpp

Rectangle{
	id: mainItem
	property AccountGui account
	signal avatarClicked()
	signal backgroundClicked()
	
	height: 45 * DefaultStyle.dp
	MouseArea{
		anchors.fill: parent
		onClicked: mainItem.backgroundClicked()
	}
	RowLayout{
		anchors.fill: parent
		spacing: 0
		Avatar{
			id: avatar
			Layout.preferredWidth: 45 * DefaultStyle.dp
			Layout.preferredHeight: 45 * DefaultStyle.dp
			account: mainItem.account
			MouseArea{
				anchors.fill: parent
				onClicked: mainItem.avatarClicked()
			}
		}
		ContactDescription{
			id: description
			Layout.fillWidth: true
			Layout.fillHeight: true
			Layout.leftMargin: 10 * DefaultStyle.dp
			account: mainItem.account
		}
		Item{
			id: registrationStatusItem
			Layout.preferredWidth: 97 * DefaultStyle.dp
			Layout.fillHeight: true
			Rectangle{
				id: registrationStatus
				anchors.left: parent.left
				anchors.verticalCenter: parent.verticalCenter
				width: Math.min(text.implicitWidth + (2 * 8 * DefaultStyle.dp), registrationStatusItem.width)
				height: 24 * DefaultStyle.dp
				color: DefaultStyle.main2_200
				radius: 90 * DefaultStyle.dp
				Text{
					id: text
					anchors.fill: parent
					anchors.leftMargin: 8 * DefaultStyle.dp
					anchors.rightMargin: 8 * DefaultStyle.dp
					verticalAlignment: Text.AlignVCenter	
					horizontalAlignment: Text.AlignHCenter
					visible: mainItem.account
					readonly property int mode : !mainItem.account || mainItem.account.core.registrationState == LinphoneEnums.RegistrationState.Ok
													? 0
													: mainItem.account.core.registrationState == LinphoneEnums.RegistrationState.Cleared || mainItem.account.core.registrationState == LinphoneEnums.RegistrationState.None
														? 1
														: mainItem.account.core.registrationState == LinphoneEnums.RegistrationState.Progress || mainItem.account.core.registrationState == LinphoneEnums.RegistrationState.Refreshing
															? 2
															: 3
					// Test texts
					//Timer{
					//	running: true
					//	interval: 1000
					//	repeat: true
					//	onTriggered: text.mode = (++text.mode) % 4
					//}
					font.weight: 300 * DefaultStyle.dp
					font.pixelSize: 12 * DefaultStyle.dp
					color: mode == 0 
							? DefaultStyle.success_500main
							: mode == 1
								? DefaultStyle.warning_600
								: mode == 2
									? DefaultStyle.main2_500main
									: DefaultStyle.danger_500main
					text: mode == 0
							? 'Connecté'
							: mode == 1
								? 'Désactivé'
								: mode == 2
									? 'Connexion...'
									: 'Erreur'
				}
			}
		}
		Item{
			Layout.preferredWidth: 100 * DefaultStyle.dp
			Layout.fillHeight: true
			Rectangle{
				id: unreadNotifications
				anchors.left: parent.left
				anchors.leftMargin: 10 * DefaultStyle.dp
				anchors.verticalCenter: parent.verticalCenter
				visible: unreadCount.text > 0
				width: 22 * DefaultStyle.dp
				height: 22 * DefaultStyle.dp
				radius: width/2
				color: DefaultStyle.danger_500main
				border.color: DefaultStyle.grey_0
				border.width: 2 * DefaultStyle.dp
				Text{
					id: unreadCount
					anchors.fill: parent
					anchors.margins: 2 * DefaultStyle.dp
					verticalAlignment: Text.AlignVCenter
					horizontalAlignment: Text.AlignHCenter
					color: DefaultStyle.grey_0
					minimumPixelSize: 5
					fontSizeMode: Text.Fit
					font.pixelSize: 20 *  DefaultStyle.dp
					property var unread: mainItem.account.core.unreadNotifications
					text: unread > 100 ? '+' : unread
				}
			}
		}
		EffectImage {
			id: manageAccount
			image.source: AppIcons.manageProfile
			Layout.preferredWidth: 24 * DefaultStyle.dp
			Layout.preferredHeight: 24 * DefaultStyle.dp
			Layout.alignment: Qt.AlignHCenter
			image.sourceSize.width: 24 * DefaultStyle.dp
			image.fillMode: Image.PreserveAspectFit
			colorizationColor: DefaultStyle.main2_500main
			MouseArea{ // TODO
				anchors.fill: parent
				onClicked: console.log('TODO: Manage!')
			}
		}
	}
}
