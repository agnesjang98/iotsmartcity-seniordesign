function
Q=force(ct1,ct2,kt1,kt2,ms,a1,a2,mt1,mt2,r1,r2,r_dot1,r_dot2,velocity,t,delta1,delta2,N)
global rou l
a=a1+a2;
g=9.876;
W1=(ms*a2/a+mt1)*g;
W2=(ms*a1/a+mt2)*g;
Q=zeros(N,1);
Q(3)=(ct1*r_dot1+kt1*r1)*delta1;
Q(4)=(ct2*r_dot2+kt2*r2)*delta2;
for n=1:N-4;
    phi1n=sqrt(2/rou/l)*sin(n*pi*t*velocity/l);
    phi2n=sqrt(2/rou/l)*sin(n*pi*(t*velocity-a)/l);
    Q(n+4)=-(phi1n*W1*delta1+phi2n*W2*delta2);
end