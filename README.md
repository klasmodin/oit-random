# Random sampling by optimal information transport

This is a `MATLAB` which uses the framework of [optimal information transport](http://dx.doi.org/10.1007/s12220-014-9469-2) to generate random samples from nonuniform, smooth probability distributions on a Riemannian manifold.
The basic method is to solve a density matching problem by an algorithm developed in [this paper](http://dx.doi.org/10.1137/151006238), thereby matching a uniform density from which samples can be drawn with the desired nonuniform density.
The computed diffeomorphism is then used to transform from the uniform to the nonuniform samples.
More details of the algorithm is available in [this paper](http://dx.doi.org/10.1137/151006238).

## Installing
Download all the `MATLAB` source files (`*.m`) and add the corresponding folder to the `MATLAB` search path. 

## Example usage
Here is a brief description of how to use the code.

Assume that the density of the desired nonuniform probability distribution is available as an array `mu` in `MATLAB`.
As an example, the function `funnydist` can be used to obtain a nonuniform distribution as follows:
```matlab
dim = 256;
[X,Y] = meshgrid(linspace(-pi,pi,dim),linspace(-pi,pi,dim));
mu = funnydist(X,Y);
```
We assume that the density is periodic is both directions and we think of the domain as being `[1,257)x[1,257)`.
Here is a plot of `mu` using the plot command `imagesc`:

<img src="https://github.com/kmodin/oit-random/blob/master/figures/example1_mu.jpg" alt="Figure of mu" width="65%"/>

The first step is to generate a diffeomorphism `phi` that matches the uniform density with `mu`. 
This is accomplished by the function `oit` as follows
```matlab
nsteps = 100;
phi = oit(mu, nsteps);
```
The variable `nsteps` specify how many steps we shall use in the time integration needed in the algorithm (for details see the full paper).
For densities that are _close_ to the uniform density, one can decrease the number of time steps to, say, 10 without loosing to much accuracy.
The computed warp can be displayed by
```matlab
plot_diffeo(phi,4);
```
She second argument to `plot_diffeo` specifies the downsample, so the only every 4th mesh-line of the warp is shown.
The result looks like in the figure below.

<img src="https://github.com/kmodin/oit-random/blob/master/figures/example1_phi.jpg" alt="Figure of mu" width="60%"/>

Next, we draw `10^5` samples from the probability distribution corresponding to `mu` by the following command:
```matlab
s = generate_samples(phi, 10^5);
```
The result `s` is an `[2 10^5]` matrix whose columns consists of the generated samples.
We may now plot the samples using the `scatter` command in `MATLAB`
```matlab
scatter(s(2,:),s(1,:),2,'filled', 'MarkerFaceColor','k',...
       'MarkerFaceAlpha',0.1,'MarkerEdgeAlpha',0);
axis([1 dim+1 1 dim+1]);
set(gca,'dataAspectRatio',[1 1 1]);
set(gca,'Ydir','reverse')
```
Notice here that we need to flip the y-axis in order to conform with the standard of `imagesc`.
The resulting figure looks as follows

<img src="https://github.com/kmodin/oit-random/blob/master/figures/example1_samples.jpg" alt="Figure of mu" width="60%"/>

To generate more samples is very fast. 
For example, another ten million samples is generated in less than a second on a standard laptop.
```matlab
tic
s = generate_samples(phi, 10^7);
toc
```

The example discussed here is available in full by the script files `run_example1.m` and `plot_example1.m` as part of the repository.
