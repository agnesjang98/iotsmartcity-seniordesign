function r=irregularity(level,N,nl,nu,x)
Gdn0=4^(level+1)*10^(-6);
detal_n=(nu-nl)/N;
n0=0.1;
r=zeros(length(x),1);
W=2;
    for k=1:N
    nk=nl+(k-0.5)*detal_n;
    Gdn=Gdn0*(nk/n0)^(-W);
    Ank=sqrt(4*Gdn*detal_n);
    r=r+Ank*cos(2*pi*nk*x+rand(1)*2*pi);
end