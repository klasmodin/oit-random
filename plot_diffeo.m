%
% Available under MIT license. See file LICENSE.
%
function plot_diffeo(phi, downsample)
    if nargin < 2
        downsample = 4;
    end
    linewidth = 0.5;

    dim = size(phi,2);
    phi1 = squeeze(phi(1,:,:));
    phiext(1,:,:) = [phi1-dim phi1-dim phi1-dim;
                     phi1     phi1     phi1;
                     phi1+dim phi1+dim phi1+dim];
    phi2 = squeeze(phi(2,:,:));
    phiext(2,:,:) = [phi2-dim phi2 phi2+dim;
                     phi2-dim phi2 phi2+dim;
                     phi2-dim phi2 phi2+dim];
    plot(squeeze(phiext(2,:,1:downsample:end)),...
         squeeze(phiext(1,:,1:downsample:end)),...
         'k','LineWidth',linewidth);
    hold on;
    plot(squeeze(phiext(2,1:downsample:end,:))',...
         squeeze(phiext(1,1:downsample:end,:))',...
         'k','LineWidth',linewidth);
    hold off;
    axis([1 dim+1 1 dim+1]);
    set(gca,'dataAspectRatio',[1 1 1]);
    set(gca,'Ydir','reverse')
    set(gca,'box','on');
end