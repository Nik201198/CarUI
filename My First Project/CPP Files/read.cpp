#include "read.h"
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QObject>
#include <QDebug>
#include <QStandardItemModel>
#include <QFile>
#include <QDir>
#include <QTimer>

read::read(QObject *parent) : QObject(parent)
{
    arduino = new QSerialPort();
    QString readdataBuffer = "";
    QString readdataBuffer2 = "";
    QString byte3 = "0";
    timer = new QTimer();
    timer2 = new QTimer();
    read::readPassword();
    QString startS = "s1:0,s2:1,s3:000,s4:000#";
    proces = new QProcess(this);
    
//qDebug()<<"###PRogram Start!";
//    foreach(const QSerialPortInfo &serialPortInfo, QSerialPortInfo::availablePorts()){
//        if(serialPortInfo.hasProductIdentifier() && serialPortInfo.hasVendorIdentifier()){
//            if((serialPortInfo.productIdentifier() == arduino_uno_product_id)
//                    && (serialPortInfo.vendorIdentifier() == arduino_uno_vendor_id)){
//                arduino_is_available = true;
//                arduino_uno_port_name = serialPortInfo.portName();

//            }
//        }
//    }
    foreach(const QSerialPortInfo &serialPortInfo, QSerialPortInfo::availablePorts ()){
        if(serialPortInfo.portName() == "ttyS0"){
             arduino_is_available = true;
             arduino_uno_port_name = serialPortInfo.portName();
        }
    }
    if(arduino_is_available){
        qDebug() << "Found the arduino port...\n";
        arduino->setPortName(arduino_uno_port_name);
        arduino->open(QSerialPort::ReadWrite);
        arduino->setBaudRate(QSerialPort::Baud4800);
        arduino->setDataBits(QSerialPort::Data8);
        arduino->setFlowControl(QSerialPort::NoFlowControl);
        arduino->setParity(QSerialPort::NoParity);
        arduino->setStopBits(QSerialPort::OneStop);
        QObject::connect(timer, SIGNAL(timeout()),this , SLOT(configWrite()));
        QObject::connect(arduino, SIGNAL(readyRead()), this, SLOT(serialRead()));
        qDebug() << "Configuration of SerialPort";
        timer->start(250);
//        timer2->start(5000);
    }else{
        qDebug() << "Couldn't find the correct port for the arduino.\n";
    }
}
void read::serialRead()
{
    QString s ="s";
//    read::serialWrite(s);
    QByteArray readData = arduino->readLine();
//    qDebug()<< "received:" <<readData;
    readdataBuffer =readdataBuffer + QString::fromStdString(readData.toStdString());
    if(readdataBuffer.endsWith("#")){
        QStringList  buffer_split1 = readdataBuffer.split(";");
        qDebug()<<"QString list:"<<buffer_split1;
        readdataBuffer = "";
        read::process(buffer_split1);
    }
//    qDebug() << "Read Data Function";
}

void read::process(const QStringList &a)
{

    buffer_split = a;
    byte1 = str = buffer_split[0];
    str = buffer_split[1];
    QString str2 = buffer_split[2];
    QString str3 = buffer_split[3];
//    qDebug()<< "Gear Changed" <<str3;
//    qDebug()<<"valByte1:"<<byte1;
    if(byte1 == "1"){
        read::setData(str);
        read::setCal_value(str);
        read::setCurrent_Data(str2);
//        read::setFileData(str2);
        read::setGear_C(str3);
//        read::setFileData2(str);
        read::readFileData();
        read::readPassword();
//        qDebug()<<"if statement byte == 1";
    }
    if(byte1 >= "2"){
        read::setData(str);
        read::setCal_value(str);
        read::setCurrent_Data(str2);
        read::setFileData(str2);
        read::setGear_C(str3);
        read::setFileData2(str);
        read::wTimeout(str2);
        read::readCal();
        read::readPassword();
    }
//    qDebug() << "Split Data Function";
    read::serialWrite();
}


void read::serialWrite()
{
    QString writeData = "s";
    if(byte1 == "1"){
        k = "";
        QString one = writeData+"1:"+byte3+","+writeData+"2:"+"2"+",";
        QString two = writeData+"3:"+ mainn +",";
        QString three = writeData+"4:"+byte2+"#";
        k = one+two+three;
//        qDebug()<<"sent Str for byte 1:"<<k;
////        qDebug()<<"s3"<<mainn;
////        qDebug()<<"s4"<<byte2;
//        qDebug()<<"__________________________________";
    }
    if(byte1 == "2"){
        k = "";
        QString one =  writeData+"1:"+"0"+","+writeData+"2:"+"3"+",";
        QString two = writeData+"3:"+byte3+",";
        QString three = writeData+"4:"+byte2+"#";
        k = one+two+three;
//        qDebug()<<"sent string str for byte 2:"<<k;
////        qDebug()<<"s3"<<mainn;
////        qDebug()<<"s4"<<byte2;
//        qDebug()<<"__________________________________";
    }
//    qDebug() << "Write Data into K ";
}


void read::configWrite()
{

     QString starts = "s1:0,s2:1,s3:000,s4:000#";
     if(k == ""){
         arduino->flush();
         arduino->write(starts.toStdString().c_str());
         qDebug() << "config write sent first:" << starts;
     }else{
         arduino->flush();
         arduino->write(k.toStdString().c_str());
         qDebug() << " config write sent:" << k;
     }
//     qDebug() << "Write K to Serial Port:";

}


void read::setFileData(const QString &w)
{
    //FILE FOR STORING CURRENT CONSUMPTION
    QFile file("graphData.txt");
    QString my = w;

    if(file.open(QFile::ReadOnly | QFile::WriteOnly | QIODevice::Text | QIODevice::Append)){
        QTextStream out(&file);
//        qDebug()<<r;
        if(r == 0){
            out << '\n' << my << ',';
            r++;
        }
        if(r < 200 && r > 0){
            out <<  my << ",";
            r++;
        }
        if(r == 200){
            out << my << "," << '\n';
            r = 1;
        }
    }
}


void read::setFileData2(const QString &q)
{
        //FILE FOR STORING COUL_COUNT
        QFile file("mydata.txt");
        QString my2 = q;
        if(file.open(QFile::ReadOnly | QFile::WriteOnly | QFile::Text)){
            QTextStream out(&file);
            out << my2 <<",";
            out.seek(0);
        }
        file.close();
}


void read::setCal(const QString &s)
{
    QFile file("Callibration.txt");
    if(file.open(QFile::ReadOnly | QFile::WriteOnly | QFile::Text)){
        QTextStream out(&file);
        out << s <<"!";
        out.seek(0);
    }
}


void read::readCal()
{
    QFile file("Callibration.txt");
    QTextStream in(&file);
    if(file.exists()){
        if(file.open(QFile::ReadOnly | QFile::WriteOnly | QFile::Text)){
            while(!in.atEnd()){
                QString ori_c_value1 = in.readAll();
                QStringList c_value_list = ori_c_value1.split("!");
                ori_c_value = c_value_list[0];
                emit show_CalChanged();
            }
        }
    }
}



void read::wTimeout(const QString &c)
{
    float val = c.toFloat();
    qDebug()<<"Current"<<val;
    m_wValue.setX(m_wValue.x() + 1);
    m_wValue.setY(val);
    emit wValueChanged();
}


void read::readFileData()
{
    //READ COUL_COUNT FROM THE FILE
    QFile file("mydata.txt");
    QTextStream in(&file);
    if(file.exists()){
        if(file.open(QFile::ReadOnly | QFile::WriteOnly | QFile::Text)){
            while(!in.atEnd()){
                mainRead = in.readAll();
                QStringList m1 = mainRead.split(",");
                mainn = m1[0];
                qDebug()<<"Read File:"<<mainn;
            }
        }
    }
}


void read::setCallibrationn(QString &cal)
{
    if(c_Value == cal)
        return;
    c_Value = cal;
    read::setCal(c_Value);
    emit callibrationnChanged();
}


void read::setPassword(QString &pass)
{
    if(m_password1 == pass){
        return;
    }
    m_password1 = pass;
    read::writePassword(m_password1);
    emit passwordChanged();
}

void read::writePassword(QString &pa)
{
    QFile file("Password.txt");
    if(file.open(QFile::ReadOnly | QFile::WriteOnly | QFile::Truncate)){
        QTextStream out(&file);
        out << pa <<"#";
        out.seek(0);
    }
}


void read::readPassword()
{
    QFile file("Password.txt");
    QTextStream in(&file);
    if(file.exists()){
        if(file.open(QFile::ReadOnly | QFile::WriteOnly | QFile::Text)){
            while(!in.atEnd()){
                QString password = in.readAll();
                QStringList passwordList = password.split("#");
                m_password = passwordList[0];
            }
        }
    }
}

void read::screenProcess()
{
//    if(gearCInfo == "100" && screen == "off"){
//        terminalWriteON();
//    }
//    if(gearCInfo == "000" && screen == "on"){
//        terminalWriteOFF();
//    }
}

void read::terminalWriteOFF()
{
    QStringList a;
    a.append("display_power");
    a.append("0");
    proces->start("vcgencmd", a);
    screen = "off";
//    timer2->setInterval(2000);
}

void read::terminalWriteON()
{
    QStringList a;
    a.append("display_power");
    a.append("0");
    proces->start("vcgencmd", a);
    screen = "on";
    timer2->setInterval(2000);
}


void read::setData(const QString &a)
{
    setmsg = a;
    emit dataChanged();
}


void read::setCurrent_Data(const QString &c)
{
    setmsg2 = c;
    emit current_DataChanged();
}


read::~read()
{
    if(arduino->isOpen()){
        arduino->close();
    }
}


QString read::data()
{
    qDebug()<< "Data:"<<setmsg;
    return setmsg;
}


QString read::current_Data()
{
    return setmsg2;
}


void read::setCal_value(const QString &v)
{
    QString var = v;
    float var1 = (var.toFloat() / ori_c_value.toFloat()) * 100;
    callibration = QString::number(var1, 'g', 2);
    emit cal_valueChanged();
}


void read::setGear(const QString &g)
{
    if(gearInfo != g){
        gearInfo = g;
        byte2 = gearInfo;
        qDebug()<<gearInfo;
        emit GearChanged();
    }
}

void read::setGear_C(const QString &gc)
{
    if(gearCInfo != gc){
        gearCInfo = gc;
        qDebug()<<"Gear Changed to"<<gearCInfo;
        emit Gear_CChanged();
    }
}


QString read:: cal_value(){
    return callibration;
}


QString read::Gear()
{
    return gearInfo;
}


QString read::Gear_C()
{
    return gearCInfo;
}


