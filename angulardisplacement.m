clc
clear
close all
l=16;
a1=4.2;
a2=4.2;
a=a1+a2;
rou=9360;
velocity=40*1000/3600;
T=(l+a)/velocity;
dt=0.000001*T;
t=0:dt:T;
load('D:\MATLABDATA\differentvelocity\X40')
%% Change X V A for displacement, velocity and accelraction [rows1,columns1]=size(X);
X_location=X(2,:);
rou=9360;
plot(t*velocity,X_location,'r-','LineWidth',1)
hold on
l=16;
a1=4.2;
a2=4.2;
a=a1+a2;
rou=9360;
velocity=80*1000/3600;
T=(l+a)/velocity;
dt=0.000001*T;
t=0:dt:T; load('D:\MATLABDATA\differentvelocity\X80') 
[rows1,columns1]=size(X);
X_location=X(2,:);
rou=9360; 
plot(t*velocity,X_location,'b--','LineWidth',1)
hold on
l=16;
a1=4.2;
a2=4.2;
a=a1+a2;
rou=9360;
velocity=120*1000/3600;
T=(l+a)/velocity;
dt=0.000001*T;
t=0:dt:T; 
load('D:\MATLABDATA\differentvelocity\X120') 
[rows1,columns1]=size(X);
X_location=X(2,:);
rou=9360; 
plot(t*velocity,X_location,'g-.','LineWidth',1)
hold on
l=16;
a1=4.2;
a2=4.2;
a=a1+a2;
rou=9360;
velocity=160*1000/3600;
T=(l+a)/velocity;
dt=0.000001*T;
% the speed of the car
% the speed of the car
t=0:dt:T;
load('D:\MATLABDATA\differentvelocity\X160') 
[rows1,columns1]=size(X);
X_location=X(2,:);
rou=9360;
plot(t*velocity,X_location,'k:','LineWidth',1)
xlabel('The location of vehicle (m)')
ylabel('The node angular displacement of vehicle (m)')
title(' The node angular displacement of vehicle in different speeds') 
legend('40km/h','80km/h','120km/h','160km/h','location','north')