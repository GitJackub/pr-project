#include "TcpClient.h"
#include <QDebug>

TcpClient::TcpClient(QObject *parent) : QObject(parent)
{
    socket = new QTcpSocket(this);

    connect(socket, &QTcpSocket::connected, this, &TcpClient::onConnected);
    connect(socket, &QTcpSocket::disconnected, this, &TcpClient::onDisconnected);
    connect(socket, &QTcpSocket::readyRead, this, &TcpClient::onReadyRead);
    connect(socket, &QTcpSocket::errorOccurred, this, &TcpClient::onError);
}

void TcpClient::connectToHost(const QString &ip, quint16 port)
{
    qDebug() << "[INFO] Connection request. IP: " << ip << ", Port: " << port;
    if(socket->state() == QTcpSocket::ConnectedState)
    {
        qDebug() << "[WARN] Already connected.";
        return;
    }
    if(socket->state() == QTcpSocket::ConnectingState)
    {
        qDebug() << "[WARN] Already connecting, please wait.";
        return;
    }
    socket->connectToHost(ip,port);
}

void TcpClient::onError(QTcpSocket::SocketError socketError)
{
    QString error;
    qDebug() << "[ERR] Error: " << socket->errorString();

    switch (socketError)
    {
    case QTcpSocket::ConnectionRefusedError:
        error = "Połączenie odrzucone, sprawdź dostępność serwera.";
        qDebug() << "[ERR] Connection refused. Make sure the server is running and accessible.";
        break;
    case QTcpSocket::HostNotFoundError:
        error = "Nie odnaleziono hosta, sprawdź poprawność adresu IP.";
        qDebug() << "[ERR] Host not found. Check the IP address.";
        break;
    case QTcpSocket::NetworkError:
        error = "Błąd sieci, sprawdź połączenie internetowe.";
        qDebug() << "[ERR] Network error. Check your network connection.";
        break;
    case QTcpSocket::SocketTimeoutError:
        error = "Przekroczono czas oczekiwania.";
        qDebug() << "[ERR] Connection timed out. Try again later.";
        break;
    default:
        error = "Wystąpił nieznany błąd.";
        qDebug() << "[ERR] An unknown error occurred.";
        break;
    }
    emit connectionError(error);
}

void TcpClient::sendMessage(const QString &message)
{
    if(socket->state() == QTcpSocket::ConnectedState){
        socket->write(message.toUtf8());
    }
}

void TcpClient::onConnected()
{
    qDebug() << "[INFO] Connected to server";
    emit connectedToServer();
}

void TcpClient::onDisconnected()
{
    qDebug() << "[INFO] Disconnected from server";
    emit disconnectedFromServer();
}

void TcpClient::onReadyRead()
{
    qDebug() << "[INFO] Received:" << socket->readAll();
}
