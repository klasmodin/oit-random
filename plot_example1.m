%
% Example 1 in GSI 2017 paper on random sampling
% This script is for generating the figures.
%
close all

savefigs = false;
showticks = true;
showcontours = true;

%%%%%%%%%%%%%%%%%%%%%%%
% Plot the density mu
%%%%%%%%%%%%%%%%%%%%%%%
figure()
lims = [min(mu(:)) max(mu(:))];
imagesc(mu,lims);
if showcontours
    hold on
    contour(mu,10,'LineColor',[1 1 1]);
    hold off
end
set(gca,'dataAspectRatio',[1 1 1]);
colorbar;
if showticks == false
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
end
set(gca,'box','on');
title('Density');
if savefigs
	print('-djpeg', 'figures/example1_mu.jpg', '-r300');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot the generated samples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
scatter(s(2,:),s(1,:),2,'filled', 'MarkerFaceColor','k',...
       'MarkerFaceAlpha',0.1,'MarkerEdgeAlpha',0);
axis([1 dim+1 1 dim+1]);
set(gca,'dataAspectRatio',[1 1 1]);
set(gca,'Ydir','reverse')
if showticks == false
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
end
set(gca,'box','on');
title('Samples');
if savefigs
	print('-djpeg', 'figures/example1_samples.jpg', '-r300');
end

%%%%%%%%%%%%%%%%%%%%%%%%
% Plot the diffeo warp
%%%%%%%%%%%%%%%%%%%%%%%%
figure()
plot_diffeo(phi, 4);
if showticks == false
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
end
title('Warp');
if savefigs
	print('-djpeg', 'figures/example1_phi.jpg', '-r300');
end
