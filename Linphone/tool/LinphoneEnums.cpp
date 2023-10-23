/*
 * Copyright (c) 2024 Belledonne Communications SARL.
 *
 * This file is part of linphone-desktop
 * (see https://www.linphone.org).
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "LinphoneEnums.hpp"
#include "Constants.hpp"

#include <QQmlEngine>
#include <QString>

// =============================================================================

void LinphoneEnums::registerMetaTypes() {
	qRegisterMetaType<LinphoneEnums::CallStatus>();
	qRegisterMetaType<LinphoneEnums::ChatMessageState>();
	qRegisterMetaType<LinphoneEnums::ChatRoomState>();
	qRegisterMetaType<LinphoneEnums::ConferenceLayout>();
	qRegisterMetaType<LinphoneEnums::ConferenceInfoState>();
	qRegisterMetaType<LinphoneEnums::ConferenceSchedulerState>();
	qRegisterMetaType<LinphoneEnums::EventLogType>();
	qRegisterMetaType<LinphoneEnums::FriendCapability>();
	qRegisterMetaType<LinphoneEnums::MediaEncryption>();
	qRegisterMetaType<LinphoneEnums::ParticipantDeviceState>();
	qRegisterMetaType<LinphoneEnums::RecorderState>();
	qRegisterMetaType<LinphoneEnums::RegistrationState>();
	qRegisterMetaType<LinphoneEnums::TunnelMode>();
	qRegisterMetaType<LinphoneEnums::TransportType>();
	qmlRegisterUncreatableMetaObject(LinphoneEnums::staticMetaObject, Constants::MainQmlUri, 1, 0, "LinphoneEnums",
	                                 "Only enums");
}

linphone::MediaEncryption LinphoneEnums::toLinphone(const LinphoneEnums::MediaEncryption &data) {
	return static_cast<linphone::MediaEncryption>(data);
}
LinphoneEnums::MediaEncryption LinphoneEnums::fromLinphone(const linphone::MediaEncryption &data) {
	return static_cast<LinphoneEnums::MediaEncryption>(data);
}

linphone::Friend::Capability LinphoneEnums::toLinphone(const LinphoneEnums::FriendCapability &data) {
	return static_cast<linphone::Friend::Capability>(data);
}
LinphoneEnums::FriendCapability LinphoneEnums::fromLinphone(const linphone::Friend::Capability &data) {
	return static_cast<LinphoneEnums::FriendCapability>(data);
}

linphone::EventLog::Type LinphoneEnums::toLinphone(const LinphoneEnums::EventLogType &data) {
	return static_cast<linphone::EventLog::Type>(data);
}
LinphoneEnums::EventLogType LinphoneEnums::fromLinphone(const linphone::EventLog::Type &data) {
	return static_cast<LinphoneEnums::EventLogType>(data);
}

linphone::ChatMessage::State LinphoneEnums::toLinphone(const LinphoneEnums::ChatMessageState &data) {
	return static_cast<linphone::ChatMessage::State>(data);
}
LinphoneEnums::ChatMessageState LinphoneEnums::fromLinphone(const linphone::ChatMessage::State &data) {
	return static_cast<LinphoneEnums::ChatMessageState>(data);
}

linphone::ChatRoom::State LinphoneEnums::toLinphone(const LinphoneEnums::ChatRoomState &data) {
	return static_cast<linphone::ChatRoom::State>(data);
}

LinphoneEnums::ChatRoomState LinphoneEnums::fromLinphone(const linphone::ChatRoom::State &data) {
	return static_cast<LinphoneEnums::ChatRoomState>(data);
}

linphone::Call::Status LinphoneEnums::toLinphone(const LinphoneEnums::CallStatus &data) {
	return static_cast<linphone::Call::Status>(data);
}
LinphoneEnums::CallStatus LinphoneEnums::fromLinphone(const linphone::Call::Status &data) {
	return static_cast<LinphoneEnums::CallStatus>(data);
}

linphone::Conference::Layout LinphoneEnums::toLinphone(const LinphoneEnums::ConferenceLayout &layout) {
	if (layout != LinphoneEnums::ConferenceLayout::AudioOnly) return static_cast<linphone::Conference::Layout>(layout);
	else return linphone::Conference::Layout::Grid; // Audio Only mode
}

LinphoneEnums::ConferenceLayout LinphoneEnums::fromLinphone(const linphone::Conference::Layout &layout) {
	return static_cast<LinphoneEnums::ConferenceLayout>(layout);
}

linphone::ConferenceInfo::State LinphoneEnums::toLinphone(const LinphoneEnums::ConferenceInfoState &state) {
	return static_cast<linphone::ConferenceInfo::State>(state);
}

LinphoneEnums::ConferenceInfoState LinphoneEnums::fromLinphone(const linphone::ConferenceInfo::State &state) {
	return static_cast<LinphoneEnums::ConferenceInfoState>(state);
}

linphone::ConferenceScheduler::State LinphoneEnums::toLinphone(const LinphoneEnums::ConferenceSchedulerState &state) {
	return static_cast<linphone::ConferenceScheduler::State>(state);
}

LinphoneEnums::ConferenceSchedulerState LinphoneEnums::fromLinphone(const linphone::ConferenceScheduler::State &state) {
	return static_cast<LinphoneEnums::ConferenceSchedulerState>(state);
}

linphone::ParticipantDevice::State LinphoneEnums::toLinphone(const LinphoneEnums::ParticipantDeviceState &state) {
	return static_cast<linphone::ParticipantDevice::State>(state);
}

LinphoneEnums::ParticipantDeviceState LinphoneEnums::fromLinphone(const linphone::ParticipantDevice::State &state) {
	return static_cast<LinphoneEnums::ParticipantDeviceState>(state);
}

linphone::Tunnel::Mode LinphoneEnums::toLinphone(const LinphoneEnums::TunnelMode &data) {
	return static_cast<linphone::Tunnel::Mode>(data);
}
LinphoneEnums::TunnelMode LinphoneEnums::fromLinphone(const linphone::Tunnel::Mode &data) {
	return static_cast<LinphoneEnums::TunnelMode>(data);
}

linphone::Recorder::State LinphoneEnums::toLinphone(const LinphoneEnums::RecorderState &data) {
	return static_cast<linphone::Recorder::State>(data);
}
LinphoneEnums::RecorderState LinphoneEnums::fromLinphone(const linphone::Recorder::State &data) {
	return static_cast<LinphoneEnums::RecorderState>(data);
}

linphone::RegistrationState LinphoneEnums::toLinphone(const LinphoneEnums::RegistrationState &data) {
	return static_cast<linphone::RegistrationState>(data);
}

LinphoneEnums::RegistrationState LinphoneEnums::fromLinphone(const linphone::RegistrationState &data) {
	return static_cast<LinphoneEnums::RegistrationState>(data);
}

linphone::TransportType LinphoneEnums::toLinphone(const LinphoneEnums::TransportType &type) {
	return static_cast<linphone::TransportType>(type);
}
LinphoneEnums::TransportType LinphoneEnums::fromLinphone(const linphone::TransportType &type) {
	return static_cast<LinphoneEnums::TransportType>(type);
}
QString LinphoneEnums::toString(const LinphoneEnums::TransportType &type) {
	switch (type) {
		case TransportType::Tcp:
			return "TCP";
		case TransportType::Udp:
			return "UDP";
		case TransportType::Tls:
			return "TLS";
		case TransportType::Dtls:
			return "DTLS";
	}
}
void LinphoneEnums::fromString(const QString &transportType, LinphoneEnums::TransportType *transport) {
	if (transportType.toUpper() == QLatin1String("TCP")) *transport = TransportType::Tcp;
	else if (transportType.toUpper() == QLatin1String("UDP")) *transport = TransportType::Udp;
	else if (transportType.toUpper() == QLatin1String("TLS")) *transport = TransportType::Tls;
	else *transport = TransportType::Dtls;
}