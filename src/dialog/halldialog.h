#ifndef HALLDIALOG_H
#define HALLDIALOG_H

#include <QDialog>
#include <QTableWidget>

class MainWindow;

class HallDialog : public QDialog
{
    Q_OBJECT
public:
    static HallDialog *GetInstance(MainWindow *main_window);
    void joinRoom(int room_id);
    void roomBegin(int total, int pagelimit);
    void room(int room_id, int joined, const QString &setup_string);
    void roomEnd();
    explicit HallDialog(MainWindow *main_window);

private:
    // explicit HallDialog(MainWindow *main_window); 20111214

    MainWindow *main_window;
    QTableWidget *table;
    int current_page;
    int room_row;

private slots:
    void pageUp();
    void pageDown();
    void join();
    void createRoom();
    void toggleDisplay(bool only_nonful);
    void refreshRooms();
    void updateRoomListTable(QString room);
signals:
    void refresh_rooms();
    void create_room();
    void join_room(int);
};

#endif // HALLDIALOG_H
