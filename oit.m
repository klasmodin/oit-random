%
% Available under MIT license. See file LICENSE.
%
function [phi, phiinv] = oit(mu, timesteps)

    % Set default number of timesteps
    if nargin < 2
        timesteps = 10;
    end

    % Compute dimensions
    dims = size(mu);
    assert(length(dims)==2, 'Only 2D densities implemented.');
    
    % Compute total volume
    vol = sum(mu(:));

    % Constructe the half-density from the input
    sqrho1 = sqrt(mu);

    % Compute angle in geodesic
    theta = acos(sum(sqrho1(:))/vol);
    assert(theta > 0, 'Some problem with geodesic distance: theta <= 0.');
    sintheta = sin(theta); % Used later several times
    
    % Construct Laplace and Laplace inverse operators in Fourier space
    L = zeros(dims);
    for u = 0:dims(1)-1
        for v = 0:dims(2)-1
            L(u+1,v+1) = -2*(cos(2*pi*u/dims(1))+cos(2*pi*v/dims(2)))+4;
        end
    end
    L(1,1) = 1;
    Linv = 1./L;
    L(1,1) = 0;
    Linv(1,1) = 1;

    % Define some diffeomorphisms
    id = identity_diffeo(dims);
    phi = identity_diffeo(dims);
    if nargout > 1
        phiinv = identity_diffeo(dims);
    end
    % Calculate the step-size
    dt = 1/timesteps;
    
    for k=1:timesteps
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Calculate geodesic and its derivative at time t
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        t = k*dt;
        sqrho = sqrho1*(sin(t*theta)/sintheta);
        sqrho = sqrho + sin((1-t)*theta)/sintheta;
        dsqrho = sqrho1*(theta*cos(t*theta)/sintheta);
        dsqrho = dsqrho - theta*cos((1-t)*theta)/sintheta;

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Lift path to the diffeomorphism group
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        % Calculate the source term in Poisson equation
        drho_over_rho = 2*dsqrho./sqrho;
        s = compose_function(drho_over_rho,phi);       
        %s = deformImagePeriodic(drho_over_rho,phi);
        
        % Solve the lifting equation
        f = -real(ifftn(fftn(s).*Linv));   
        v = function_gradient(f);
        psi = id - dt*v;
        phi = compose_vectorfield(phi-id,psi)+psi;
        if nargout > 1
            v = compose_vectorfield(v,phiinv);
            phiinv = phiinv + dt*v;
        end
    end
end
