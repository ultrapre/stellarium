/*
 * Stellarium
 * Copyright (C) 2008 Fabien Chereau
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Suite 500, Boston, MA  02110-1335, USA.
*/


#include "StelDialog.hpp"
#include "StelDialog_p.hpp"
#include "StelMainView.hpp"
#include "StelGui.hpp"
#include "StelActionMgr.hpp"
#include "StelPropertyMgr.hpp"

#include <QDebug>
#include <QAbstractButton>
#include <QComboBox>
#include <QDialog>
#include <QGraphicsSceneWheelEvent>
#include <QMetaProperty>
#include <QStyleOptionGraphicsItem>
#include <QSlider>
#include <QSpinBox>
#include <QDoubleSpinBox>
#include <QLineEdit>
#if defined(Q_OS_WIN) || defined(Q_OS_ANDROID)
	#include <QScroller>
#endif

StelDialog::StelDialog(QString dialogName, QObject* parent)
	: QObject(parent)
	, dialog(Q_NULLPTR)
	, proxy(Q_NULLPTR)
	, dialogName(dialogName)
{
	if (parent == Q_NULLPTR)
		setParent(StelMainView::getInstance().getGuiWidget());
}

StelDialog::~StelDialog()
{
}

void StelDialog::close()
{
	setVisible(false);
}

bool StelDialog::visible() const
{
	return dialog!=Q_NULLPTR && dialog->isVisible();
}

void StelDialog::setVisible(bool v)
{
	if(v == visible())
		return;
	if (v)
	{
		QSize screenSize = StelMainView::getInstance().size();
		QSize maxSize = 0.8*screenSize;
		if (dialog)
		{
			dialog->show();
			StelMainView::getInstance().scene()->setActiveWindow(proxy);
			
#if !defined(Q_OS_ANDROID)
			// If the main window has been resized, it is possible the dialog
			// will be off screen.  Check for this and move it to a visible
			// position if necessary
			QPointF newPos = proxy->pos();
			if (newPos.x()>=screenSize.width())
				newPos.setX(screenSize.width() - dialog->size().width());
			if (newPos.y()>=screenSize.height())
				newPos.setY(screenSize.height() - dialog->size().height());
			if (newPos != dialog->pos())
				proxy->setPos(newPos);
			QSizeF newSize = proxy->size();
			if (newSize.width() >= maxSize.width())
				newSize.setWidth(maxSize.width());
			if (newSize.height() >= maxSize.height())
				newSize.setHeight(maxSize.height());
			if(newSize != dialog->size())
				proxy->resize(newSize);
#endif
		}
		else
		{
			QGraphicsWidget* parent = qobject_cast<QGraphicsWidget*>(this->parent());
			dialog = new QDialog(Q_NULLPTR);
			// dialog->setParent(parent);
			StelGui* gui = dynamic_cast<StelGui*>(StelApp::getInstance().getGui());
			Q_ASSERT(gui);
			//dialog->setAttribute(Qt::WA_OpaquePaintEvent, true);
			connect(dialog, SIGNAL(rejected()), this, SLOT(close()));
			createDialogContent();
			dialog->setStyleSheet(gui->getStelStyle().qtStyleSheet);

			// Ensure that tooltip get rendered in red in night mode.
			connect(&StelApp::getInstance(), SIGNAL(visionNightModeChanged(bool)), this, SLOT(updateNightModeProperty()));
			updateNightModeProperty();

			proxy = new CustomProxy(parent, Qt::Tool,this);
			proxy->setWidget(dialog);

			connect(proxy, SIGNAL(sizeChanged(QSizeF)), this, SLOT(handleDialogSizeChanged(QSizeF)));

#if !defined(Q_OS_ANDROID)
			QSizeF size = proxy->size();

			int newX, newY;

			// Retrieve panel locations from config.ini, but shift if required to a visible position.
			// else centre dialog according to current window size.
			QSettings *conf=StelApp::getInstance().getSettings();
			Q_ASSERT(conf);
			QString confNamePt="DialogPositions/" + dialogName;
			QString storedPosString=conf->value(confNamePt,
							    QString("%1,%2")
							    .arg((int)((screenSize.width()  - size.width() )/2))
							    .arg((int)((screenSize.height() - size.height())/2)))
					.toString();
			QStringList posList=storedPosString.split(",");
			if (posList.length()==2)
			{
				newX=posList.at(0).toInt();
				newY=posList.at(1).toInt();
			}
			else	// in case there is an invalid string?
			{
				newX=(int)((screenSize.width()  - size.width() )/2);
				newY=(int)((screenSize.height() - size.height())/2);
			}

			if (newX>=screenSize.width())
				newX= (screenSize.width()  - dialog->size().width());
			if (newY>=screenSize.height())
				newY= (screenSize.height() - dialog->size().height());

			// Make sure that the window's title bar is accessible
			if (newY <-0)
				newY = 0;
			proxy->setPos(newX, newY);
			proxy->setWindowFrameMargins(2,0,2,2);
			// (this also changes the bounding rectangle size)

			// Retrieve stored panel sizes, scale panel up if it was stored larger than default.
			QString confNameSize="DialogSizes/" + dialogName;
			QString storedSizeString=conf->value(confNameSize, QString("0,0")).toString();
			QStringList sizeList=storedSizeString.split(",");
			if (sizeList.length()==2)
			{
				newX=sizeList.at(0).toInt();
				newY=sizeList.at(1).toInt();
			}
			else	// in case there is an invalid string?
			{
				newX=0;
				newY=0;
			}
			// resize only if number was valid and larger than default loaded size.
			if ( (newX>=proxy->size().width()) || (newY>=proxy->size().height()) )
			{
				//qDebug() << confNameSize << ": resize to " << storedSizeString;
				proxy->resize(qMax((qreal)newX, proxy->size().width()), qMax((qreal)newY, proxy->size().height()));
			}
			if(proxy->size().width() > maxSize.width() || proxy->size().height() > maxSize.height())
			{
				proxy->resize(maxSize);
			}
#endif
			
			handleDialogSizeChanged(proxy->size()); // This may trigger internal updates in subclasses. E.g. LocationPanel location arrow.

			// The caching is buggy on all platforms with Qt 4.5.2
			proxy->setCacheMode(QGraphicsItem::ItemCoordinateCache);

			proxy->setZValue(100);
			StelMainView::getInstance().scene()->setActiveWindow(proxy);
		}

#if defined(Q_OS_ANDROID)
		proxy->setPos(0,0);
		proxy->resize(screenSize);
		proxy->setWindowFrameMargins(0,0,0,0);
#endif
		
		proxy->setFocus();
	}
	else
	{
		dialog->hide();
		//proxy->clearFocus();
		StelMainView::getInstance().focusSky();
	}
	emit visibleChanged(v);
}

void StelDialog::connectCheckBox(QAbstractButton *checkBox, const QString &actionName)
{
	StelAction* action = StelApp::getInstance().getStelActionManager()->findAction(actionName);
	connectCheckBox(checkBox,action);
}

void StelDialog::connectCheckBox(QAbstractButton *checkBox, StelAction *action)
{
	Q_ASSERT(action);
	checkBox->setChecked(action->isChecked());
	connect(action, SIGNAL(toggled(bool)), checkBox, SLOT(setChecked(bool)));
	connect(checkBox, SIGNAL(toggled(bool)), action, SLOT(setChecked(bool)));
}

void StelDialog::connectIntProperty(QLineEdit* lineEdit, const QString& propName)
{
	StelProperty* prop = StelApp::getInstance().getStelPropertyManager()->getProperty(propName);
	Q_ASSERT_X(prop,"StelDialog", "StelProperty does not exist");

	//use a proxy for the connection
	new QLineEditStelPropertyConnectionHelper(prop,lineEdit);
}

void StelDialog::connectIntProperty(QSpinBox *spinBox, const QString &propName)
{
	StelProperty* prop = StelApp::getInstance().getStelPropertyManager()->getProperty(propName);
	Q_ASSERT_X(prop,"StelDialog", "StelProperty does not exist");

	//use a proxy for the connection
	new QSpinBoxStelPropertyConnectionHelper(prop,spinBox);
}

void StelDialog::connectIntProperty(QComboBox *comboBox, const QString &propName)
{
	StelProperty* prop = StelApp::getInstance().getStelPropertyManager()->getProperty(propName);
	Q_ASSERT_X(prop,"StelDialog", "StelProperty does not exist");

	//use a proxy for the connection
	new QComboBoxStelPropertyConnectionHelper(prop,comboBox);
}

void StelDialog::connectIntProperty(QSlider *slider, const QString &propName,int minValue, int maxValue)
{
	StelProperty* prop = StelApp::getInstance().getStelPropertyManager()->getProperty(propName);
	Q_ASSERT_X(prop,"StelDialog", "StelProperty does not exist");

	//The connection is handled by a helper class. It is automatically destroyed when the slider is destroyed.
	new QSliderStelPropertyConnectionHelper(prop,minValue,maxValue,slider);
}

void StelDialog::connectDoubleProperty(QDoubleSpinBox *spinBox, const QString &propName)
{
	StelProperty* prop = StelApp::getInstance().getStelPropertyManager()->getProperty(propName);
	Q_ASSERT_X(prop,"StelDialog", "StelProperty does not exist");

	//use a proxy for the connection
	new QDoubleSpinBoxStelPropertyConnectionHelper(prop,spinBox);
}

void StelDialog::connectDoubleProperty(QSlider *slider, const QString &propName,double minValue, double maxValue)
{
	StelProperty* prop = StelApp::getInstance().getStelPropertyManager()->getProperty(propName);
	Q_ASSERT_X(prop,"StelDialog", "StelProperty does not exist");

	//The connection is handled by a helper class. It is automatically destroyed when the slider is destroyed.
	new QSliderStelPropertyConnectionHelper(prop,minValue,maxValue,slider);
}

void StelDialog::connectBoolProperty(QAbstractButton *checkBox, const QString &propName)
{
	StelProperty* prop = StelApp::getInstance().getStelPropertyManager()->getProperty(propName);
	Q_ASSERT_X(prop,"StelDialog", "StelProperty does not exist");

	new QAbstractButtonStelPropertyConnectionHelper(prop,checkBox);
}

#if defined(Q_OS_WIN) || defined(Q_OS_ANDROID)
void StelDialog::installKineticScrolling(QList<QWidget *> addscroll)
{
	//return; // Temporary disable feature, bug in Qt: https://bugreports.qt-project.org/browse/QTBUG-41299

	if (StelApp::getInstance().getSettings()->value("gui/flag_enable_kinetic_scrolling", true).toBool() == false)
		return;

	foreach(QWidget * w, addscroll)
	{
		QScroller::grabGesture(w, QScroller::LeftMouseButtonGesture);
		QScroller::scroller(w);
	}
}
#endif


void StelDialog::updateNightModeProperty()
{
	dialog->setProperty("nightMode", StelApp::getInstance().getVisionModeNight());
}

void StelDialog::handleMovedTo(QPoint newPos)
{
#if !defined(Q_OS_ANDROID)
	QSettings *conf=StelApp::getInstance().getSettings();
	Q_ASSERT(conf);
	conf->setValue("DialogPositions/" + dialogName, QString("%1,%2").arg(newPos.x()).arg(newPos.y()));
#endif
}

void StelDialog::handleDialogSizeChanged(QSizeF size)
{
#if !defined(Q_OS_ANDROID)
	QSettings *conf=StelApp::getInstance().getSettings();
	Q_ASSERT(conf);
	conf->setValue("DialogSizes/" + dialogName, QString("%1,%2").arg((int)size.width()).arg((int)size.height()));
#endif
}


//// --- Implementation of StelDialog_p.hpp classes follow ---

QAbstractButtonStelPropertyConnectionHelper::QAbstractButtonStelPropertyConnectionHelper(StelProperty *prop, QAbstractButton *button)
	:StelPropertyProxy(prop,button), button(button)
{
	QVariant val = prop->getValue();
	bool ok = val.canConvert<bool>();
	Q_ASSERT_X(ok,"QAbstractButtonStelPropertyConnectionHelper","Can not convert to bool datatype");
	Q_UNUSED(ok);
	onPropertyChanged(val);

	//in this direction, we can directly connect because Qt supports QVariant slots with the new syntax
	connect(button, &QAbstractButton::toggled, prop, &StelProperty::setValue);
}

void QAbstractButtonStelPropertyConnectionHelper::onPropertyChanged(const QVariant &value)
{
	//block signals to prevent sending the valueChanged signal, changing the property again
	bool b = button->blockSignals(true);
	button->setChecked(value.toBool());
	button->blockSignals(b);
}

QComboBoxStelPropertyConnectionHelper::QComboBoxStelPropertyConnectionHelper(StelProperty *prop, QComboBox *combo)
	:StelPropertyProxy(prop,combo), combo(combo)
{
	QVariant val = prop->getValue();
	bool ok = val.canConvert<int>();
	Q_ASSERT_X(ok,"QComboBoxStelPropertyConnectionHelper","Can not convert to int datatype");
	Q_UNUSED(ok);
	onPropertyChanged(val);

	//in this direction, we can directly connect because Qt supports QVariant slots with the new syntax
	connect(combo, static_cast<void (QComboBox::*)(int)>(&QComboBox::activated),prop,&StelProperty::setValue);
}

void QComboBoxStelPropertyConnectionHelper::onPropertyChanged(const QVariant &value)
{
	//block signals to prevent sending the valueChanged signal, changing the property again
	bool b = combo->blockSignals(true);
	combo->setCurrentIndex(value.toInt());
	combo->blockSignals(b);
}


QLineEditStelPropertyConnectionHelper::QLineEditStelPropertyConnectionHelper(StelProperty *prop, QLineEdit *edit)
	:StelPropertyProxy(prop,edit), edit(edit)
{
	QVariant val = prop->getValue();
	bool ok = val.canConvert<int>();
	Q_ASSERT_X(ok,"QLineEditStelPropertyConnectionHelper","Can not convert to int datatype");
	Q_UNUSED(ok);
	onPropertyChanged(val);

	//in this direction, we can directly connect because Qt supports QVariant slots with the new syntax
	connect(edit, static_cast<void (QLineEdit::*)(const QString&)>(&QLineEdit::textEdited),prop,&StelProperty::setValue);
}

void QLineEditStelPropertyConnectionHelper::onPropertyChanged(const QVariant &value)
{
	//block signals to prevent sending the valueChanged signal, changing the property again
	bool b = edit->blockSignals(true);
	edit->setText(value.toString());
	edit->blockSignals(b);
}

QSpinBoxStelPropertyConnectionHelper::QSpinBoxStelPropertyConnectionHelper(StelProperty *prop, QSpinBox *spin)
	:StelPropertyProxy(prop,spin), spin(spin)
{
	QVariant val = prop->getValue();
	bool ok = val.canConvert<int>();
	Q_ASSERT_X(ok,"QSpinBoxStelPropertyConnectionHelper","Can not convert to int datatype");
	Q_UNUSED(ok);
	onPropertyChanged(val);

	//in this direction, we can directly connect because Qt supports QVariant slots with the new syntax
	connect(spin, static_cast<void (QSpinBox::*)(int)>(&QSpinBox::valueChanged),prop,&StelProperty::setValue);
}

void QSpinBoxStelPropertyConnectionHelper::onPropertyChanged(const QVariant &value)
{
	//block signals to prevent sending the valueChanged signal, changing the property again
	bool b = spin->blockSignals(true);
	spin->setValue(value.toInt());
	spin->blockSignals(b);
}

QDoubleSpinBoxStelPropertyConnectionHelper::QDoubleSpinBoxStelPropertyConnectionHelper(StelProperty *prop, QDoubleSpinBox *spin)
	:StelPropertyProxy(prop,spin), spin(spin)
{
	QVariant val = prop->getValue();
	bool ok = val.canConvert<double>();
	Q_ASSERT_X(ok,"QDoubleSpinBoxStelPropertyConnectionHelper","Can not convert to double datatype");
	Q_UNUSED(ok);
	onPropertyChanged(val);

	//in this direction, we can directly connect because Qt supports QVariant slots with the new syntax
	connect(spin, static_cast<void (QDoubleSpinBox::*)(double)>(&QDoubleSpinBox::valueChanged),prop,&StelProperty::setValue);
}

void QDoubleSpinBoxStelPropertyConnectionHelper::onPropertyChanged(const QVariant &value)
{
	//block signals to prevent sending the valueChanged signal, changing the property again
	bool b = spin->blockSignals(true);
	spin->setValue(value.toDouble());
	spin->blockSignals(b);
}

QSliderStelPropertyConnectionHelper::QSliderStelPropertyConnectionHelper(StelProperty *prop, double minValue, double maxValue, QSlider *slider)
	: StelPropertyProxy(prop,slider),slider(slider),minValue(minValue),maxValue(maxValue)
{
	QVariant val = prop->getValue();
	bool ok = val.canConvert<double>();
	Q_ASSERT_X(ok,"QSliderStelPropertyConnectionHelper","Can not convert to double datatype");
	Q_UNUSED(ok);

	dRange = maxValue - minValue;
	onPropertyChanged(val);

	connect(slider,SIGNAL(valueChanged(int)),this,SLOT(sliderIntValueChanged(int)));
}

QSliderStelPropertyConnectionHelper::QSliderStelPropertyConnectionHelper(StelProperty *prop, int minValue, int maxValue, QSlider *slider)
	: StelPropertyProxy(prop,slider),slider(slider),minValue(minValue),maxValue(maxValue)
{
	QVariant val = prop->getValue();
	bool ok = val.canConvert<double>();
	Q_ASSERT_X(ok,"QSliderStelPropertyConnectionHelper","Can not convert to double datatype");
	Q_UNUSED(ok);

	dRange = maxValue - minValue;
	onPropertyChanged(val);

	connect(slider,SIGNAL(valueChanged(int)),this,SLOT(sliderIntValueChanged(int)));
}
void QSliderStelPropertyConnectionHelper::sliderIntValueChanged(int val)
{
	double dVal = ((val - slider->minimum()) / (double)(slider->maximum() - slider->minimum())) * dRange + minValue;
	prop->setValue(dVal);
}

void QSliderStelPropertyConnectionHelper::onPropertyChanged(const QVariant& val)
{
	double dVal = val.toDouble();
	int iRange = slider->maximum() - slider->minimum();
	int iVal = qRound(((dVal - minValue)/dRange) * iRange + slider->minimum());
	bool b = slider->blockSignals(true);
	slider->setValue(iVal);
	slider->blockSignals(b);
}


CustomProxy::CustomProxy(QGraphicsItem *parent, Qt::WindowFlags wFlags , StelDialog* _dialog ) : QGraphicsProxyWidget(parent, wFlags)
{
	setFocusPolicy(Qt::StrongFocus);
	dialog = _dialog;
}


//! Reimplement this method to add windows decorations. Currently there are invisible 2 px decorations
void CustomProxy::paintWindowFrame(QPainter*, const QStyleOptionGraphicsItem*, QWidget*)
{
/*			QStyleOptionTitleBar bar;
	initStyleOption(&bar);
	bar.subControls = QStyle::SC_TitleBarCloseButton;
	qWarning() << style()->subControlRect(QStyle::CC_TitleBar, &bar, QStyle::SC_TitleBarCloseButton);
	QGraphicsProxyWidget::paintWindowFrame(painter, option, widget);*/
}


bool CustomProxy::event(QEvent* event)
{
	if (StelApp::getInstance().getSettings()->value("gui/flag_use_window_transparency", true).toBool())
	{
		switch (event->type())
		{
			case QEvent::WindowDeactivate:
				widget()->setWindowOpacity(0.4);
				break;
			case QEvent::WindowActivate:
			case QEvent::GrabMouse:
				widget()->setWindowOpacity(0.9);
				break;
			default:
				break;
		}
	}
	return QGraphicsProxyWidget::event(event);
}


void CustomProxy::resizeEvent(QGraphicsSceneResizeEvent *event)
{
	if (event->newSize() != event->oldSize())
	{
		emit sizeChanged(event->newSize());
	}
	QGraphicsProxyWidget::resizeEvent(event);
}