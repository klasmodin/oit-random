%
% Available under MIT license. See file LICENSE.
%
function g = compose_function(f,phi)
% compute g = f \circ phi by interpolation
    persistent interfun;
    dims = size(phi);
    switch length(dims)-1
        case 2
            % move points outside the domain using periodic bc
            phix = mod(squeeze(phi(:,:,1))-1,dims(1))+1;
            phiy = mod(squeeze(phi(:,:,2))-1,dims(2))+1;

            % extend im periodically
            imext = [f f(:,1);f(1,:) f(1,1)];
            
            % call interpolation routine
            if isempty(interfun)
                interfun = griddedInterpolant(imext);
            else
                try
                    interfun.Values = imext;
                catch
                    interfun = griddedInterpolant(imext);
                end
            end
            try
                g = interfun(phix, phiy);
            catch
                interfun = griddedInterpolant(imext);
                g = interfun(phix, phiy);
            end
            
            % OLD STYLE INTERPOLATION (slower)
%             g = interpn(imext, phix, phiy, 'linear');
            
        case 3
            error('Only 2D diffeos implemented.');
        otherwise
            error('Dimension not implemented.');
    end
end  
