function [Nbits, MSE] = audio_vq(infile, bitfile, outfile, M, N)
x = audioread(infile);
randn(M,N,
