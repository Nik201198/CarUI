#ifndef READ_H
#define READ_H

#include <QObject>
#include <QString>
#include <QSerialPort>
#include <QStandardItemModel>
#include <QTimer>
#include <QProcess>


class read : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString data READ data WRITE setData NOTIFY dataChanged)
    Q_PROPERTY(QString cal_value READ cal_value WRITE setCal_value NOTIFY cal_valueChanged)
    Q_PROPERTY(QString current_Data READ current_Data WRITE setCurrent_Data NOTIFY current_DataChanged)
    Q_PROPERTY(QString Gear READ Gear WRITE setGear NOTIFY GearChanged)
    Q_PROPERTY(QString Gear_C READ Gear_C WRITE setGear_C NOTIFY Gear_CChanged)
    Q_PROPERTY(QPointF wValue READ wValue NOTIFY wValueChanged)
    Q_PROPERTY(QString callibrationn READ callibrationn WRITE setCallibrationn NOTIFY callibrationnChanged)
    Q_PROPERTY(QString show_Cal READ show_Cal NOTIFY show_CalChanged)
    Q_PROPERTY(QString password READ password WRITE setPassword NOTIFY passwordChanged)


public:
    explicit read(QObject *parent = nullptr);
    void setData(const QString &a);
    void setCurrent_Data(const QString &c);
    void setCal_value(const QString &v);
    void setGear(const QString &g);
    void setGear_C(const QString &gc);
    void readFileData();
    void setCallibrationn(QString &cal);
    QPointF wValue() const { return m_wValue; }
    QString show_Cal() const {return ori_c_value;};
    void setPassword(QString &pass);
    void writePassword(QString &pa);
    ~read();

public slots:
    void serialWrite();
    void configWrite();
    QString password() const {return m_password;};
    QString data();
    QString current_Data();
    QString cal_value();
    QString callibrationn(){return c_Value;};
    QString Gear();
    QString Gear_C();
    void serialRead();
    void setFileData(const QString &w);
    void setFileData2(const QString &q);
    void wTimeout(const QString &c);
    void process(const QStringList &a);
    void setCal(const QString &s);
    void readCal();
    void readPassword();
    void terminalWriteOFF();
    void terminalWriteON();
    void screenProcess();

signals:
    void callibrationnChanged();
    void dataChanged();
    void cal_valueChanged();
    void current_DataChanged();
    void GearChanged();
    void Gear_CChanged();
    void wValueChanged();
    void show_CalChanged();
    void passwordChanged();

private:
    bool arduino_is_available = false;
    QString arduino_uno_port_name;
    static const quint16 arduino_uno_product_id =29987;
    static const quint16 arduino_uno_vendor_id = 6790;
    QSerialPort *arduino;
    QTimer *timer;
    QTimer *timer2;
    QProcess *proces;
    QByteArray readData;
    QByteArray ba;
    QString setmsg;
    QString setmsg2;
    QString readdataBuffer;
    QString readdataBuffer2;
    QString str;
    QString k;
    QString i = "0";
    QString byte1;
    QString byte2;
    QString byte3 ;
    QByteArray linebuff;
    QString callibration;
    QString mainn;
    QString gearInfo , gearCInfo, mainRead;
    int index =0;
    QPointF m_wValue;
    QStringList buffer_split;
    QString c_Value;
    QString ori_c_value;
    QString m_password;
    QString m_password1;
    int r = 0;
    QString screen = "on";
};
#endif // READ_H
