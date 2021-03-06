% afdd2.m  BUTTON: AFD DESIGN D2
%   
%          Advanced Analog Filter Design - AFDesign
%   
%   Authors: Dejan V. Tosic, Miroslav D. Lutovac, 1999/02/21
%   tosic@galeb.etf.bg.ac.yu   http://www.rcub.bg.ac.yu/~tosicde/
%   lutovac@iritel.bg.ac.yu    http://galeb.etf.bg.ac.yu/~lutovac/
%   Copyright (c) 1999-2000 by Tosic & Lutovac
%   $Revision: 1.21 $  $Date: 2000/10/03 13:45$
%   
%   References:
%   Miroslav D. Lutovac, Dejan V. Tosic, Brian L. Evans
%        Filter Design for Signal Processing
%           Using MATLAB and Mathematica
%        Prentice Hall - ISBN 0-201-36130-2 
%         http://www.prenhall.com/lutovac
%
                         
% This file is part of AFDesign toolbox for MATLAB.
% Refer to the file LICENSE.TXT for full details.
%                        
% AFDesign version 2.1, Copyright (c) 1999-2000 D. Tosic and M. Lutovac
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; see LICENSE.TXT for details.
%                       
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%                       
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc.,  59 Temple Place,  Suite 330,  Boston,
% MA  02111-1307  USA,  http://www.fsf.org/

%% calls:
%% afdesign.m, afddemo.m, afdopen.m, afdview.m, afdedit.m
%% afdplot.m, afdpass.m, afdtran.m, afdstop.m, afdzoom.m
%% afdd1.m, afdd2.m, afdd3a.m, afdd3b.m, afdd4a.m, afdd4b.m
%% afdd5.m, afd2d5.m, afd3d5.m, 

tstart = clock;
[numD,denD,numH,denH,nD,aD,eD,fpD] = afdd2(speck,ninc,filtype);
desnumb=2;
destype='D2';
eseconds=etime(clock,tstart);
afddinfo;
clf;
moreaxis=afdplot(numD,denD,speca,filnumb,moreaxis,'D2');
Dtype = 'D2';
sizespeca = length(speca);
if sizespeca==4
  title([sprintf('%s : Sa= %11.1d Hz %11.1d Hz %9.5f dB %9.1d dB',Dtype, speca)],'FontSize',9);
elseif sizespeca==7
  if speca(6)<3
    title([sprintf('%s : Sa= %11.1d Hz %11.1d Hz %11.1d Hz %11.1d Hz %5.1d dB %9.5f dB %5.1d dB',Dtype,speca)],'FontSize',7);
  elseif (speca(5)+speca(5))<6
    title([sprintf('%s : Sa= %11.1d Hz %11.1d Hz %11.1d Hz %11.1d Hz %9.5f dB %9.1d dB %9.5f dB',Dtype,speca)],'FontSize',7);
  else
    title([sprintf('%s : Sa= %11.1d Hz %11.1d Hz %11.1d Hz %11.1d Hz %9.1d dB %9.1d dB %9.1d dB',Dtype,speca)],'FontSize',7);
  end
else
  title([sprintf('%s : Sa= %11.1d Hz %11.1d Hz %9.1d dB %9.1d dB',Dtype, speca)],'FontSize',9);
end
