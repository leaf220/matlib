function testPlot(tempsoln)
global handle f h Nf beta;

delete(handle);
handle=plot(f,dB(fft(double(optimal(h,tempsoln)),Nf)));
%delete(hLevel);
%hLevel=plot(fsb,ones(size(fsb))*dB(double(optimal(beta,tempsoln))),'c.');
drawnow;
