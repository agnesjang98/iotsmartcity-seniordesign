function [M,C,K]=MCK(ms,mt1,mt2,J,ks1,ks2,cs1,cs2,kt1,kt2,ct1,ct2,a1,a2,N,delta1,delta2,t,velocity)
%% N is the dimemsions of the matrix
global rou EI l mu
% rou is the constant like density ????
%% M matrix
M=zeros(N,N);
M1=[ms,J,mt1,mt2];
M1=diag(M1);
a=a1+a2;
for n=1:N-4
    phi1n=sqrt(2/rou/l)*sin(n*pi*t*velocity/l);
    phi2n=sqrt(2/rou/l)*sin(n*pi*(t*velocity-a)/l);
    M(n+4,1)=(a1*phi1n*delta1+a2*phi2n*delta2)*ms/a;
    M(n+4,2)=(phi1n*delta1-phi2n*delta2)*J/a;
    M(n+4,3)=phi1n*delta1*mt1;
    M(n+4,4)=phi2n*delta2*mt2;
end
M2=ones(N-4,1);
M2=diag(M2);
M(1:4,1:4)=M1;
M(5:N,5:N)=M2;
%% C matrix
C=zeros(N,N);
for n=1:N-4
    phi1n=sqrt(2/rou/l)*sin(n*pi*t*velocity/l);
    phi2n=sqrt(2/rou/l)*sin(n*pi*(t*velocity-a)/l);
    C(3,n+4)=-ct1*phi1n*delta1;
    C(4,n+4)=-ct2*phi2n*delta2;
end
C1=[cs1+cs2,cs1*a1-cs2*a2,-cs1,-cs2;...
cs1*a1-cs2*a2,cs1*a1^2+cs2*a2^2,-cs1*a1,cs2*a2;...
-cs1,-cs1*a1,cs1+ct1,0;...
-cs2,cs2*a2,0,cs2+ct2];
C2=mu/rou*diag(ones(N-4,1));
C(1:4,1:4)=C1;
C(5:N,5:N)=C2;
%% K matrix
K=zeros(N,N);
omega_n_2=zeros(1,N-4);
for n=1:N-4
    phi1n=sqrt(2/rou/l)*sin(n*pi*t*velocity/l);
    phi2n=sqrt(2/rou/l)*sin(n*pi*(t*velocity-a)/l);
    phi1n_dot=n*pi/l*sqrt(2/rou/l)*cos(n*pi*t*velocity/l);
    phi2n_dot=n*pi/l*sqrt(2/rou/l)*cos(n*pi*(t*velocity-a)/l);
    K(3,n+4)=(-ct1*phi1n_dot-kt1*phi1n)*delta1;
    K(4,n+4)=(-ct2*phi2n_dot-kt2*phi2n)*delta2;
    omega_n_2(1,n)=EI/rou*(n*pi/l)^4;
end
K1=[ks1+ks2,ks1*a1-ks2*a2,-ks1,-ks2;...
ks1*a1-ks2*a2,ks1*a1^2+ks2*a2^2,-ks1*a1,ks2*a2;...
-ks1,-ks1*a1,ks1+kt1,0;...
-ks2,ks2*a2,0,ks2+kt2];
K2=diag(omega_n_2);
K(1:4,1:4)=K1;
K(5:N,5:N)=K2;
