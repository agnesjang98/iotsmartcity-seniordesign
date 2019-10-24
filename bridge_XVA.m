function X=bridge_XVA(modes,L,xG,mp)
%NM the mode shape % L the length of the bridge % xG the location
NM=length(modes);
X=zeros(size(xG));
for i=1:NM
    X=X+sqrt(2/mp/L)*sin(i*pi*xG/L)*modes(i);
end