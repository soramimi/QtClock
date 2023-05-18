#ifndef CLOCKWIDGET_H
#define CLOCKWIDGET_H

#include <QDateTime>
#include <QWidget>

class ClockWidget : public QWidget {
	Q_OBJECT
private:
	QDateTime next_time_;
	QDateTime current_time_;

	void updateTimer();
	void setTime(const QDateTime &dt);
	void paintEvent(QPaintEvent *event) override;
public:
	explicit ClockWidget(QWidget *parent = nullptr);
};

#endif // CLOCKWIDGET_H
