%
% Available under MIT license. See file LICENSE.
%
function nablaf = function_gradient(f)
    dims = size(f);
    switch length(dims)
        case 2
            nablaf = zeros(dims(1),dims(2),2);
            nablaf(:,:,1) = (circshift(f,[-1 0]) - circshift(f,[1 0]))/2;
            nablaf(:,:,2) = (circshift(f,[0 -1]) - circshift(f,[0 1]))/2;

        case 3
            error('Only 2D diffeos implemented.');
        otherwise
            error('Dimension not implemented.');
end

