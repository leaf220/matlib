% firL2Linfeps.m
% mixed L2/Linf Nonlinear-Phase FIR filter optimization
% Dan Scholnik (scholnik@nrl.navy.mil)

K=201;  % filter length
tau=K/3;
df=1/(30*K);
fpb=[0:df:0.3-2.5/K];   Npb=length(fpb);
fsb=[0.3:df:0.5]; Nsb=length(fsb);
Dpb=ones(size(fpb));
Dsb=zeros(size(fsb));
fgrid=[fpb,fsb]; Ngrid=length(fgrid);
Dgrid=optGenSequence(fgrid,[Dpb,Dsb].*exp(-j*2*pi*fgrid*tau));
Wgrid=optGenSequence(fgrid,[ones(1,Npb), 5*ones(1,Nsb)]);

InitOpt;
ov=newOptSpace;
h=optSequence(K,ov);
Hgrid=fourier(h,fgrid);
Egrid=Wgrid*(Hgrid-Dgrid);
nu=optVar(ov);
ugrid=optGenSequence(fgrid,ov)+j*optGenSequence(fgrid,ov);
vgrid=Egrid-ugrid;
epsilon=0.01;
constr={sum(abs(ugrid).^2)<(epsilon*nu).^2,...
		  abs(vgrid)<(1-epsilon)*nu};
soln=minimize(nu,constr,ov,'sedumi_dump_nosolve','firL2Linfeps');
%soln=minimize(nu,constr,ov,'sedumi_dump','firL2Linfeps');
