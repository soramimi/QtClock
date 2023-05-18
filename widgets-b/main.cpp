#include "ClockWidget.h"
#include <QApplication>
#include <QScreen>

int main(int argc, char *argv[])
{
	QApplication a(argc, argv);
	ClockWidget w;
	w.show();

	auto s = QApplication::primaryScreen()->size();
	if (s.width() == s.height()) {
		w.setWindowState(Qt::WindowFullScreen);
	} else {
		int n = std::min(w.width(), w.height());
		w.setFixedSize(n, n);
	}

	return a.exec();
}
