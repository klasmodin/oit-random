%
% Available under MIT license. See file LICENSE.
%
function g = compose_function(f,phi)
% compute g = f \circ phi by interpolation
    dims = size(phi);
    switch dims(1)
        case 2
            phix = squeeze(phi(1,:,:));
            phiy = squeeze(phi(2,:,:));

            % move points outside the domain using periodic bc
            phix = mod(phix-1,dims(2))+1;
            phiy = mod(phiy-1,dims(3))+1;

            % extend im periodically
            imext = [f f(:,1);f(1,:) f(1,1)];
            
            % call interpolation routine
%             F = griddedInterpolant(imext);
%             g = F(phiy, phix); % Should be faster, but doesn't work
            g = interp2(imext, phiy, phix, 'linear');
            
        case 3
            error('Only 2D diffeos implemented.');
        otherwise
            error('Dimension not implemented.');
    end
end  
