#ifndef TCPCLIENT_H
#define TCPCLIENT_H

#include <QObject>
#include <QTcpSocket>

class TcpClient : public QObject
{
    Q_OBJECT
public:
    explicit TcpClient(QObject *parent = nullptr);

    Q_INVOKABLE void connectToHost(const QString &ip, quint16 port);
    Q_INVOKABLE void sendMessage(const QString &message);

signals:
    void connectedToServer();
    void disconnectedFromServer();
    void connectionError(QString);

private slots:
    void onConnected();
    void onDisconnected();
    void onReadyRead();

private:
    QTcpSocket *socket;
    void onError(QTcpSocket::SocketError socketError);
};


#endif // TCPCLIENT_H
