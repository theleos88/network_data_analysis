#! /bin/octave -qf

ipp = 750
ipc = 1.9
vector = 256;
byte_s = 8;
packet_real = 84;

tot_cycles = ipp / ipc
freq = 2.6*10^9
lat = tot_cycles/freq
lat_per_batch = lat*256

batch_rate = 1 / lat_per_batch
ndr_gbps = batch_rate *vector*byte_s*packet_real

ndr_mpps = ndr_gbps / (byte_s*packet_real)
