/*
 * Copyright (c) 2010-2024 Belledonne Communications SARL.
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

#ifndef ACCOUNT_MODEL_H_
#define ACCOUNT_MODEL_H_

#include "model/listener/Listener.hpp"
#include "tool/AbstractObject.hpp"

#include <QObject>
#include <linphone++/linphone.hh>

class AccountModel : public ::Listener<linphone::Account, linphone::AccountListener>,
                     public linphone::AccountListener,
                     public AbstractObject {
	Q_OBJECT
public:
	AccountModel(const std::shared_ptr<linphone::Account> &account, QObject *parent = nullptr);
	~AccountModel();

	virtual void onRegistrationStateChanged(const std::shared_ptr<linphone::Account> &account,
	                                        linphone::RegistrationState state,
	                                        const std::string &message) override;
	void onDefaultAccountChanged();

	void setPictureUri(QString uri);
	void setDefault();
	void removeAccount();

signals:
	void registrationStateChanged(const std::shared_ptr<linphone::Account> &account,
	                              linphone::RegistrationState state,
	                              const std::string &message);
	void defaultAccountChanged(bool isDefault);

	void pictureUriChanged(QString uri);
	void unreadNotificationsChanged(int unreadMessagesCount, int unreadCallsCount);

private:
	DECLARE_ABSTRACT_OBJECT
};

#endif
