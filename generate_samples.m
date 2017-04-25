%
% Available under MIT license. See file LICENSE.
%
function s = generate_samples(phi, n)
    dims = size(phi);
    switch dims(1)
        case 2
            % generate n uniform samples in square [1,dim+1)^2
            s0 = rand(2,n);
            s0(1,:) = dims(2)*s0(1,:)+1;
            s0(2,:) = dims(3)*s0(2,:)+1;
    
            % warp samples
            s = eval_diffeo(phi, s0);
            
            % move points outside the domain using periodic bc
            s(1,:) = mod(s(1,:)-1,dims(2))+1;
            s(2,:) = mod(s(2,:)-1,dims(3))+1;

        case 3
            error('Only 2D diffeos implemented.');
        otherwise
            error('Dimension not implemented.');
    end
    
end