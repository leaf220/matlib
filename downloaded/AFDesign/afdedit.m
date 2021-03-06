% afdedit.m  AFD specification editor (script)
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
%% afdcheck.m, afdorder.m, afda2k.m

if fig2 & find(get(0,'Children')==fig2)
 figure(fig2)
 delete(ebt)
else
 fig2 = figure;
 set(fig2, 'Name', 'Edit Specification' ...
        , 'NumberTitle', 'off' ...
        , 'Position', initsize+[140,-50,-200,-100] ...
        , 'Color',[0.25,0,0.50])
end

delete(gca);
axis off;

ebb0close = uicontrol('String', 'close', 'Units', 'normalized' ...
     , 'Position', [0.85 0.9 0.15 0.06] ...
     , 'CallBack', 'close(fig2); fig2=0; clear ebt');

ebb1save = uicontrol('String', 'save', 'Units', 'normalized' ...
     , 'Position', [0.85 0.8 0.15 0.06] ...
     , 'CallBack', ['tmpspeca=[filnumb,speca];', ...
                    '[savefile,savepath]=uiputfile(''tmpspec.dat'',''Save specification'');', ...
                    'if savefile~=0;', ...
                    'eval([''save '',savepath,savefile,'' tmpspeca -ascii'']);', ...
                    'end;']);

 et8 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.1 0.15 0.06] ...
     , 'String',   'ninc');

 eb8 = uicontrol('Style', 'edit' ...
     , 'String', num2str(ninc) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.1 0.15 0.06] ...
     , 'CallBack', ['ninc1=eval(get(eb8,''String''));', ...
                    'if ninc1>nincmax;', ...
                    'ninc=nincmin;', ...
                    'elseif ninc1<nincmin;', ...
                    'ninc=nincmax;', ...
                    'else;', ...
                    'ninc=ninc1;', ...
                    'end;', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);']);

 et9 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.13 0.02 0.35 0.06] ...
     , 'String',   [num2str(nincmin),'<=ninc<=',num2str(nincmax)]);

if     filnumb==1

 text(0,1.0, 'Lowpass');

 et1 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.8 0.15 0.06] ...
     , 'String',   'Fpass');

 eb1 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(1)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.8 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb1,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(1)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(1)=newspeca;', ...
                    'speck(1)=speca(1);', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb1,''String'',num2str(speca(1)));']);
 et2 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.7 0.15 0.06] ...
     , 'String',   'Fstop');

 eb2 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(2)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.7 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb2,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(2)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(2)=newspeca;', ...
                    'speck(2)=speca(2);', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb2,''String'',num2str(speca(2)));']);

 et3 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.6 0.15 0.06] ...
     , 'String',   'Apass');

 eb3 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(3)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.6 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb3,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(3)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(3)=newspeca;', ...
                    'speck(3)=afda2k(speca(3));', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb3,''String'',num2str(speca(3)));']);

 et4 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.5 0.15 0.06] ...
     , 'String',   'Astop');

 eb4 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(4)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.5 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb4,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(4)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(4)=newspeca;', ...
                    'speck(4)=afda2k(speca(4));', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb4,''String'',num2str(speca(4)));']);

 ebt = [eb1, eb2, eb3, eb4, ...
        et1, et2, et3, et4, ...
        eb8, et8, ...
        ebb0close, ebb1save];

elseif filnumb==2

 text(0,1.0, 'Highpass');

 et1 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.8 0.15 0.06] ...
     , 'String',   'Fstop');

 eb1 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(1)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.8 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb1,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(1)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(1)=newspeca;', ...
                    'speck(1)=speca(1);', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb1,''String'',num2str(speca(1)));']);

 et2 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.7 0.15 0.06] ...
     , 'String',   'Fpass');

 eb2 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(2)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.7 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb2,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(2)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(2)=newspeca;', ...
                    'speck(2)=speca(2);', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb2,''String'',num2str(speca(2)));']);

 et3 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.6 0.15 0.06] ...
     , 'String',   'Apass');

 eb3 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(3)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.6 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb3,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(3)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(3)=newspeca;', ...
                    'speck(3)=afda2k(speca(3));', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb3,''String'',num2str(speca(3)));']);

 et4 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.5 0.15 0.06] ...
     , 'String',   'Astop');

 eb4 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(4)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.5 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb4,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(4)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(4)=newspeca;', ...
                    'speck(4)=afda2k(speca(4));', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb4,''String'',num2str(speca(4)));']);

 ebt = [eb1, eb2, eb3, eb4, ...
        et1, et2, et3, et4, ...
        eb8, et8, ...
        ebb0close, ebb1save];

elseif filnumb==3

 text(0,1.0, 'Bandpass');

 et1 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.8 0.15 0.06] ...
     , 'String',   'Fstop1');

 eb1 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(1)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.8 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb1,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(1)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(1)=newspeca;', ...
                    'speck(1)=speca(1);', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb1,''String'',num2str(speca(1)));']);

 et2 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.7 0.15 0.06] ...
     , 'String',   'Fpass1');

 eb2 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(2)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.7 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb2,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(2)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(2)=newspeca;', ...
                    'speck(2)=speca(2);', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb2,''String'',num2str(speca(2)));']);

 et3 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.6 0.15 0.06] ...
     , 'String',   'Fpass2');

 eb3 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(3)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.6 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb3,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(3)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(3)=newspeca;', ...
                    'speck(3)=speca(3);', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb3,''String'',num2str(speca(3)));']);

 et4 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.5 0.15 0.06] ...
     , 'String',   'Fstop2');

 eb4 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(4)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.5 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb4,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(4)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(4)=newspeca;', ...
                    'speck(4)=speca(4);', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb4,''String'',num2str(speca(4)));']);

 et5 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.4 0.15 0.06] ...
     , 'String',   'Astop1');

 eb5 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(5)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.4 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb5,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(5)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(5)=newspeca;', ...
                    'speck(5)=afda2k(speca(5));', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb5,''String'',num2str(speca(5)));']);

 et6 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.3 0.15 0.06] ...
     , 'String',   'Apass');

 eb6 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(6)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.3 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb6,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(6)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(6)=newspeca;', ...
                    'speck(6)=afda2k(speca(6));', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb6,''String'',num2str(speca(6)));']);

 et7 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.2 0.15 0.06] ...
     , 'String',   'Astop2');

 eb7 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(7)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.2 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb7,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(7)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(7)=newspeca;', ...
                    'speck(7)=afda2k(speca(7));', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb7,''String'',num2str(speca(7)));']);

 ebt = [eb1, eb2, eb3, eb4, eb5, eb6, eb7, eb8, ...
        et1, et2, et3, et4, et5, et6, et7, et8, ...
        ebb0close, ebb1save];

elseif filnumb==4

 text(0,1.0, 'Bandreject');

 et1 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.8 0.15 0.06] ...
     , 'String',   'Fpass1');

 eb1 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(1)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.8 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb1,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(1)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(1)=newspeca;', ...
                    'speck(1)=speca(1);', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb1,''String'',num2str(speca(1)));']);

 et2 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.7 0.15 0.06] ...
     , 'String',   'Fstop1');

 eb2 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(2)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.7 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb2,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(2)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(2)=newspeca;', ...
                    'speck(2)=speca(2);', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb2,''String'',num2str(speca(2)));']);

 et3 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.6 0.15 0.06] ...
     , 'String',   'Fstop2');

 eb3 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(3)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.6 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb3,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(3)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(3)=newspeca;', ...
                    'speck(3)=speca(3);', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb3,''String'',num2str(speca(3)));']);

 et4 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.5 0.15 0.06] ...
     , 'String',   'Fpass2');

 eb4 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(4)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.5 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb4,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(4)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(4)=newspeca;', ...
                    'speck(4)=speca(4);', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb4,''String'',num2str(speca(4)));']);

 et5 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.4 0.15 0.06] ...
     , 'String',   'Apass1');

 eb5 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(5)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.4 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb5,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(5)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(5)=newspeca;', ...
                    'speck(5)=afda2k(speca(5));', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb5,''String'',num2str(speca(5)));']);

 et6 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.3 0.15 0.06] ...
     , 'String',   'Astop');

 eb6 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(6)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.3 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb6,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(6)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(6)=newspeca;', ...
                    'speck(6)=afda2k(speca(6));', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb6,''String'',num2str(speca(6)));']);

 et7 = uicontrol('Style', 'text' ...
     , 'Units',    'normalized' ...
     , 'Position', [0.15 0.2 0.15 0.06] ...
     , 'String',   'Apass2');

 eb7 = uicontrol('Style', 'edit' ...
     , 'String', num2str(speca(7)) ...
     , 'Units',    'normalized', 'BackgroundColor',[1 1 1] ...
     , 'Position', [0.31 0.2 0.15 0.06] ...
     , 'CallBack', ['newspeca=eval(get(eb7,''String''));', ...
                    'speca1=speca;', ...
                    'speca1(7)=newspeca;', ...
                    'if afdcheck(speca1,filnumb);', ...
                    'speca(7)=newspeca;', ...
                    'speck(7)=afda2k(speca(7));', ...
                    '[nmin,nmax,nincmin,nincmax] = afdorder(speck,filnumb);', ...
                    'ninc=0;', ...
                    'set(b16n,''String'',[''n='',num2str(nmin+ninc)]);', ...
                    'set(eb8,''String'',num2str(ninc));', ...
                    'set(et9,''String'',[num2str(nincmin),''<=ninc<='',num2str(nincmax)]);', ...
                    'end;', ...
                    'set(eb7,''String'',num2str(speca(7)));']);

 ebt = [eb1, eb2, eb3, eb4, eb5, eb6, eb7, eb8, ...
        et1, et2, et3, et4, et5, et6, et7, et8, ...
        ebb0close, ebb1save];

else
 error(['AFD ERROR: Unsupported filter type ', num2str(filnumb), '.'])

end
