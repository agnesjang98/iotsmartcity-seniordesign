clc
clear
close all
l=50;
a1=2.97;
a2=1.18;
a=a1+a2;
rou=32840;
velocity=40*1000/3600; % the speed of the car
T=(l+a)/velocity;
dt=0.000001*T;
t=0:dt:T;
load('D:\MATLABDATA\differentvelocity3\X40')
%% Change X V A for displacement, velocity and accelraction
[rows1,columns1]=size(X);
X_location=zeros(columns1,1);
rou=32840;
X_contact1=zeros(length(t),1);
X_contact2=zeros(length(t),1);
XXG1=zeros(length(t),1);
XXG2=zeros(length(t),1);
for jjj=1:length(t)
    if t(jjj)*velocity<l;
        deltal1=1;
    else deltal1=0;
    end
    
    if t(jjj)*velocity<l+a&t(jjj)*velocity>a;
        deltal2=1;
    else deltal2=0;
    end
    xG1=t(jjj)*velocity;
    xG2=t(jjj)*velocity-a;
    X_contact1(jjj)=bridge_XVA(X(5:rows1,jjj),l,xG1*deltal1,rou)*deltal1;
    X_contact2(jjj)=bridge_XVA(X(5:rows1,jjj),l,xG2*deltal2,rou)*deltal2;
    XXG1(jjj)=xG1;
    XXG2(jjj)=xG2;
end

plot(XXG1,X_contact1,'r-','LineWidth',1)
hold on
l=50;
a1=2.97;
a2=1.18;
a=a1+a2;
rou=32840;
velocity=80*1000/3600; % the speed of the car
T=(l+a)/velocity;
dt=0.000001*T;
t=0:dt:T;
load('D:\MATLABDATA\differentvelocity3\X80')
[rows1,columns1]=size(X);
X_location=zeros(columns1,1);
rou=32840;
X_contact1=zeros(length(t),1);
X_contact2=zeros(length(t),1);
XXG1=zeros(length(t),1);
XXG2=zeros(length(t),1);
for jjj=1:length(t)
    if t(jjj)*velocity<l;
        deltal1=1;
    else deltal1=0;
    end
    if t(jjj)*velocity<l+a&t(jjj)*velocity>a;
        deltal2=1;
    else deltal2=0;
    end
    xG1=t(jjj)*velocity;
    xG2=t(jjj)*velocity-a;
    X_contact1(jjj)=bridge_XVA(X(5:rows1,jjj),l,xG1*deltal1,rou)*deltal1;
    X_contact2(jjj)=bridge_XVA(X(5:rows1,jjj),l,xG2*deltal2,rou)*deltal2;
    XXG1(jjj)=xG1;
    XXG2(jjj)=xG2;
end
plot(XXG1,X_contact1,'b--','LineWidth',1)
hold on
l=50;
a1=2.97;
a2=1.18;
a=a1+a2;
rou=32840;
velocity=120*1000/3600; % the speed of the car
T=(l+a)/velocity;
dt=0.000001*T;
t=0:dt:T;
load('D:\MATLABDATA\differentvelocity3\X120')
[rows1,columns1]=size(X);
X_location=zeros(columns1,1);
rou=32840;
X_contact1=zeros(length(t),1);
X_contact2=zeros(length(t),1);
XXG1=zeros(length(t),1);
XXG2=zeros(length(t),1);
for jjj=1:length(t)
    if t(jjj)*velocity<l;
        deltal1=1;
    else deltal1=0;
    end
    if t(jjj)*velocity<l+a&t(jjj)*velocity>a;
        deltal2=1;
    else deltal2=0;
    end
    xG1=t(jjj)*velocity;
    xG2=t(jjj)*velocity-a;
    X_contact1(jjj)=bridge_XVA(X(5:rows1,jjj),l,xG1*deltal1,rou)*deltal1;
    X_contact2(jjj)=bridge_XVA(X(5:rows1,jjj),l,xG2*deltal2,rou)*deltal2;
    XXG1(jjj)=xG1;
    XXG2(jjj)=xG2;
end
plot(XXG1,X_contact1,'g-.','LineWidth',1)
hold on
l=50;
a1=2.97;
a2=1.18;
a=a1+a2;
rou=32840;
velocity=160*1000/3600; % the speed of the car
T=(l+a)/velocity;
dt=0.000001*T;
t=0:dt:T;
load('D:\MATLABDATA\differentvelocity3\X160')
[rows1,columns1]=size(X);
X_location=zeros(columns1,1);
rou=32840;
X_contact1=zeros(length(t),1);
X_contact2=zeros(length(t),1);
XXG1=zeros(length(t),1);
XXG2=zeros(length(t),1);
for jjj=1:length(t)
    if t(jjj)*velocity<l;
        deltal1=1;
    else deltal1=0;
    end
    if t(jjj)*velocity<l+a&t(jjj)*velocity>a;
        deltal2=1;
    else deltal2=0;
    end
    xG1=t(jjj)*velocity;
    xG2=t(jjj)*velocity-a;
    X_contact1(jjj)=bridge_XVA(X(5:rows1,jjj),l,xG1*deltal1,rou)*deltal1;
    X_contact2(jjj)=bridge_XVA(X(5:rows1,jjj),l,xG2*deltal2,rou)*deltal2;
    XXG1(jjj)=xG1;
    XXG2(jjj)=xG2;
end
plot(XXG1,X_contact1,'k:','LineWidth',1)
xlabel('The location of the contact point (m)')
ylabel('The dynamic displacement of bridge on the first contact point (m)')
title('The dynamic displacement of bridge on the first contact point in different speeds')
legend('40km/h','80km/h','120km/h','160km/h','location','north')