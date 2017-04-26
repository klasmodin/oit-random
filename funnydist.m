function mu = funnydist(X,Y,compressratio)
    if nargin<3
        compressratio = 100;
    end
	mu = 3*exp(-(X.^2) - 10*((Y-0.5*X.^2)+1).^2);
	mu = mu + 2*exp(-(X+1).^2 - Y.^2) + 1e-1;
    mu = mu - min(min(mu));
    mu = mu/max(max(mu));
    mu = 1 + (compressratio-1)*mu;
end