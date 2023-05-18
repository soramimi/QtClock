#include "ClockWidget.h"
#include <QDateTime>
#include <QDebug>
#include <QPainter>
#include <QPainterPath>
#include <QTimer>
#include <cmath>

ClockWidget::ClockWidget(QWidget *parent)
	: QWidget(parent)
{
	setWindowFlag(Qt::FramelessWindowHint);
	updateTimer();
}

void ClockWidget::updateTimer()
{
	QDateTime now = QDateTime::currentDateTime();
	next_time_ = now.addSecs(1);
	next_time_.setTime(QTime(next_time_.time().hour(), next_time_.time().minute(), next_time_.time().second()));
	qint64 ms = now.msecsTo(next_time_);
	QTimer::singleShot(ms, [&](){
		setTime(next_time_);
		updateTimer();
	});
}

void ClockWidget::setTime(QDateTime const &dt)
{
	current_time_ = dt;
	update();
}

void ClockWidget::paintEvent(QPaintEvent *event)
{
	if (!current_time_.isValid()) return;

	double cx = width() / 2.0;
	double cy = height() / 2.0;
	double radius = std::min(width(), height()) / 2 - 1;

	QPainter pr(this);
	pr.setRenderHint(QPainter::Antialiasing);

	pr.fillRect(rect(), Qt::black);

	pr.setBrush(Qt::white);
	pr.drawEllipse(cx - radius, cy - radius, cx + radius, cy + radius);

	pr.setPen(QPen(Qt::black, 3));

	for (int i = 0; i < 60; i++) {
		double t = i * (3.14159265358979323846264338 * 2 / 60);
		double cx = width() / 2 + 0.5;
		double cy = height() / 2 + 0.5;
		double x = sin(t) * radius;
		double y = -cos(t) * radius;
		double x0 = cx + x;
		double y0 = cy + y;
		double x1;
		double y1;
		if (i % 5 == 0) {
			x1 = cx + x * 0.9;
			y1 = cy + y * 0.9;
		} else {
			x1 = cx + x * 0.95;
			y1 = cy + y * 0.95;
		}
		pr.drawLine(QPointF(x0, y0), QPointF(x1, y1));
	}

	auto DrawHand = [&](double num, double den, double len){
		double t = num * (3.14159265358979323846264338 * 2) / den;
		double x = sin(t) * radius * len;
		double y = -cos(t) * radius * len;
		pr.drawLine(QPointF(cx, cy), QPointF(cx + x, cy + y));
	};

	double h = current_time_.time().hour();
	double m = current_time_.time().minute();
	double s = current_time_.time().second();
	m += s / 60;
	h += m / 60;
	DrawHand(h, 12, 0.5);
	DrawHand(m, 60, 0.7);
	DrawHand(s, 60, 0.85);
}
