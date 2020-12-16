#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QDebug>
#include "StelLocation.hpp"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
//    Ui_dateTimeDialogForm * ui2 = new Ui_dateTimeDialogForm();
//    ui2->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}


void MainWindow::on_pushButton_clicked()
{
    try{
        StelLocation *s1 = new StelLocation();
        qDebug()<<s1->getID();
        qDebug()<<s1->isValid();
    }
    catch (...) {
        qDebug()<<"None";
    }
//    char **argv=nullptr;
//    char *argv[]={'0'};
//    _main(0, argv);
}
