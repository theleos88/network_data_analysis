#! /bin/octave -qf

arg_list = argv ();


% Define some variables and constants
MPPS = 10^6;
real_pkt_size = (84*8);
RATE = 14.88*MPPS*real_pkt_size ;

disp ("This script prints the average waiting time W_s in (us)")

avg_latency = 10.7*10^-6;
avg_latency_ip = 250*10^-6;

% Very important! Our vector
queue_size = 4096
vector = 256

max_vector_per_queue = queue_size / vector;
line_rate_vector = vector*real_pkt_size/RATE;

% Input Rate and service time / rate (in Millions packet per second)
lambda = 14.88;
mu = 12.70
if (nargin > 0)
    lambda = str2double(arg_list{1});
endif

lambda
rho = lambda/mu

% Using the M/M/1/k system: k = 4096 (input buffer)
rho_n = ones(1,queue_size);

for i=1:queue_size
	rho_n(i) = rho^i;
endfor

P_n = ones(1,queue_size);
sum_rho_n = sum(rho_n);

for i=1:queue_size
	P_n(i) = (rho^i) / (sum_rho_n);
endfor

lambda_e = lambda*(1-P_n(queue_size));
n_P_n = ones(1,queue_size);

for i=1:queue_size
	n_P_n(i) = i*P_n(i);
endfor

sum_n_P_n = sum(n_P_n);

L_s = sum_n_P_n;
L_q = L_s - (1 - P_n(1));
W_s = L_s / lambda_e; 
printf ("DATA: %f %f\n",lambda*real_pkt_size, W_s)
disp("----------")
