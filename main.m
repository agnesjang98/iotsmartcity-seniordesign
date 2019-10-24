clc
clear
close all
% the main program global rou EI l mu l=16;
mode=30; N=mode+4; %parameters: 
ms=38500; 
mt1=4330; 
mt2=4330; 
J=2.446e6; 
ks1=2.535e6; 
ks2=2.535e6; 
cs1=1.96e5; 
cs2=1.96e5; 
kt1=4.28e6; 
kt2=4.28e6; 
ct1=9.8e4; 
ct2=9.8e4;
a1=4.2;
a2=4.2;

a=a1+a2;
global rou EI l mu
rou=9360;
EI=2.05e10;
mu=0.025;
%%
velocity=40*1000/3600; T=(l+a)/velocity;
dt=0.000001*T;
t=0:dt:T;
t=t';
x=t*velocity;
level=1;
nl=4;
NN=1000;
nu=5;
r=irregularity(level,NN,nl,nu,x); 
r_dot=(r(2:length(r))-r(1:length(r)-1))/dt;
A=zeros(N,length(t)); 
V=zeros(N,length(t));
X=zeros(N,length(t)); 
Q=zeros(N,length(t));
A0=zeros(N,1); 
V0=zeros(N,1); 
X0=zeros(N,1);
for jjj=1:length(t)
    if t(jjj)*velocity<l; delta1=1; irr1=r(jjj);
        irr_dot1=r_dot(jjj); 
    else
        delta1 = 0;
        irr1=0;
        irr_dot1=0;
    end
    if t(jjj)*velocity<l+a&t(jjj)*velocity>a; 
        delta2=1;
        irr2=r(floor((t(jjj)*velocity-a)/dt/velocity)+1);
        irr_dot2=r_dot(floor((t(jjj)*velocity-a)/dt/velocity)+1); 
    else
        delta2=0;
        irr2=0;
        irr_dot2=0;
    end
    
[M,C,K]=MCK(ms,mt1,mt2,J,ks1,ks2,cs1,cs2,kt1,kt2,ct1,ct2,a1,a2,N,delta1,delta2,t(jjj),velocity);

Q=force(ct1,ct2,kt1,kt2,ms,a1,a2,mt1,mt2,irr1,irr2,irr_dot1,irr_dot2,velocity,t(jjj),delta1,delta2,N);

A0=M\(Q-C*V0-K*X0); 
X1=X0+V0*dt+1/2*A0*dt^2; 
V1=V0+A0*dt; 
A1=M\(Q-C*V1-K*X1);
error1=1;

    while error1>0.0001
        X2=X0+V0*dt+(1/2-1/4)*A0*dt^2+1/4*A1*dt^2; V2=V0+(1-1/2)*A0*dt+1/2*A1*dt; A2=M\(Q-C*V2-K*X2);
        error1=sum(abs(abs(A2)-abs(A1)))/sum(abs(A1)); A1=A2;
        V1=V2;
        X1=X2;
    end
X0=X1;
V0=V1; 
A0=A1; 
X(:,jjj)=X0; 
V(:,jjj)=V0; 
A(:,jjj)=A0;
end

save('D:\MATLABDATA\differentvelocity\A40','A'); 
save('D:\MATLABDATA\differentvelocity\V40','V'); 
save('D:\MATLABDATA\differentvelocity\X40','X'); 
save('D:\MATLABDATA\differentvelocity\Q40','Q');


    
    