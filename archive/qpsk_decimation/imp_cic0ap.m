% $Id$
%clear all;
%clf;
dec_rate = 8;
over = dec_rate;
rcv_over = 2*over; % 2 samples/symbol
RX_M = 12*rcv_over + 1
alpha = 0.25;
% Receiver RC Filter used in calc_err
rcf = rc(alpha,rcv_over,RX_M);
norm = sqrt(sum(rcf*rcf'));
orig_rcf = rcf/norm;

%z_rcf = zeroins(orig_rcf,3);

cic_rate = 8;

imp2 = cicimp(cic_rate,3);
result = conv(imp2,orig_rcf);



