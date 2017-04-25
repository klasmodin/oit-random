function Z = funnydist(X,Y)
	Z = 3*exp(-(X.^2) - 10*((Y-0.5*X.^2)+1).^2);
	Z = Z + 2*exp(-(X+1).^2 - Y.^2) + 1e-1;
end