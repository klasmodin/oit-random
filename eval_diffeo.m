%
% Available under MIT license. See file LICENSE.
%
function s = eval_diffeo(phi, s0)
    dims = size(phi);
    switch dims(1)
        case 2
            % extend phi periodically
            phix = squeeze(phi(1,:,:));
            phiy = squeeze(phi(2,:,:));
            phiext(1,:,:) = [phix phix(:,1);phix(1,:)+dims(2) phix(1,1)+dims(2)+1];
            phiext(2,:,:) = [phiy phiy(:,1)+dims(3);phiy(1,:) phiy(1,1)+dims(3)+1];
            
            % warp samples
            s = zeros(2,size(s0,2));
            s(1,:) = interpn(squeeze(phiext(1,:,:)),s0(1,:),s0(2,:),'linear',NaN);
            s(2,:) = interpn(squeeze(phiext(2,:,:)),s0(1,:),s0(2,:),'linear',NaN);
            
        case 3
            error('Only 2D diffeos implemented.');
        otherwise
            error('Dimension not implemented.');
    end
end