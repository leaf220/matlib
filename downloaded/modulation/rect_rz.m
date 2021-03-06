function out = rect_rz(arg1,arg2)

% RECT_RZ ..... Generates a rectangular "return to zero" pulse.
%
%			+=======+           +1
%			|       |       
%			+       +=======+    0
%
%		--------+-------+-------+-----------> time
%			0      Tb/2     Tb   
%
%		There will be "SAMPLING_CONSTANT" samples to represent this 
%		pulse shape.  This function is used by the M-function WAVE_GEN.	

%	AUTHORS : M. Zeytinoglu & N. W. Ma
%             Department of Electrical & Computer Engineering
%             Ryerson Polytechnic University
%             Toronto, Ontario, CANADA
%
%	DATE    : August 1991.
%	VERSION : 1.0

%===========================================================================
% Modifications history:
% ----------------------
%	o   Added "checking"  11.30.1992 MZ
%	o	Tested (and modified) under MATLAB 4.0/4.1 08.16.1993 MZ
%===========================================================================

global START_OK;
global SAMPLING_CONSTANT;
global SAMPLING_FREQ;
global BINARY_DATA_RATE;

check;

if (nargin == 0)
   Rb = BINARY_DATA_RATE;
   fs = SAMPLING_FREQ;
elseif (nargin == 1)
   Rb = arg1;
   fs = SAMPLING_FREQ;
elseif (nargin == 2)
   Rb = arg1;
   fs = arg2;
end

n_sample = fs/Rb;
n_middle = n_sample/2;
out      = ones(1,n_sample);
out((n_middle + 1):(n_sample)) = zeros(1,(n_sample-n_middle));
