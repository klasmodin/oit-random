%
% Available under MIT license. See file LICENSE.
%
function id = identity_diffeo(dims)

    switch length(dims)
        case 1
            id = ndgrid(1:dims(1));
        case 2
            [X1,X2] = ndgrid(1:dims(1),1:dims(2));
            id(1,:,:) = X1;
            id(2,:,:) = X2;
        otherwise
            error('dimension not supported!');
    end

%     dtype = 'double';
%     switch length(dims)
%         case 2
%             [ey,ex] = meshgrid(cast(1,dtype):cast(dims(2),dtype),...
%                 cast(1,dtype):cast(dims(1),dtype));
%             id(1,:,:) = ex;
%             id(2,:,:) = ey;
%         case 3
%             [ey,ex,ez]=meshgrid(cast(1,dtype):cast(dims(2),dtype),...
%                 cast(1,dtype):cast(dims(1),dtype),...
%                 cast(1,dtype):cast(dims(3),dtype));
%             id(1,:,:,:) = ex;
%             id(2,:,:,:) = ey;
%             id(3,:,:,:) = ez;
%         otherwise
%             error('dim must be be length 2 or 3 vector');
%     end
end
