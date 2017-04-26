%
% Example 1 in GSI 2017 paper on random sampling.
% This script is for generating the samples.
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate target density
%%%%%%%%%%%%%%%%%%%%%%%%%%%
dim = 256;
[X,Y] = meshgrid(linspace(-pi,pi,dim),linspace(-pi,pi,dim));
mu = funnydist(X,Y);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute OIT diffeomorphism
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Computing warp...')
tic
timesteps = 100;
phi = oit(mu, timesteps);
toc

%%%%%%%%%%%%%%%%
% Draw samples
%%%%%%%%%%%%%%%%
disp('Generating samples...')
tic
N = 10^5;
s = generate_samples(phi,N);
toc
