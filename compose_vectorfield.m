%
% Available under MIT license. See file LICENSE.
%
function w = compose_vectorfield(v,phi)
% returns w = v \circ phi
    dims = size(phi);
    switch dims(1)
        case 2
            vx = squeeze(v(1,:,:));
            vy = squeeze(v(2,:,:));
            w(1,:,:) = compose_function(vx,phi);
            w(2,:,:) = compose_function(vy,phi);
           
        case 3
            error('Only 2D diffeos implemented.');
        otherwise
            error('Dimension not implemented.');
    end
end

