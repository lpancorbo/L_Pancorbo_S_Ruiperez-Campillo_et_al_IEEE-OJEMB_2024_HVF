% *************************************************************************
% QCEP ITACA UPV
% Spatial Inhomogeneity Index Replication
% 
% Authors: Lucía Pancorbo, Samuel Ruipérez-Campillo, Francisco Castells.
% Date: 28/07/2022
% 
% Any individual benefiting from any of this code must cite the work as:
% L.Pancorbo, S. Ruipérez-Campillo, A. Tormos, A. Guill, R. Cervigón, 
% A. Alberola, F.J. Chorro, J. Millet, F. Castells, "Vector Field 
% Heterogeneity for the Assessment of Locally Disorganised Cardiac 
% Electrical Propagation Wavefronts from High-density Multielectrodes", 
% IEEE Open Journal of Engineering in Medicine and Biology (2024).
%
% Description: Function to plot the activation map relative to the first
% activation.
% *************************************************************************
%
% PLOT_LAT_RELATIVE_MAP takes a vector containing the LATs and plots 
% a color map of the activation relative to the first activated electrode.
%
%   lat_map = PLOT_LAT_RELATIVE_MAP(lat,n_clique_1d)
%
%   Parameters:
%       lat (Double): Vector containing the LATs in seconds.
%       n_grid_1d (Unsigned Integer): Number of rows of the catheter.
%
%   Returns:
%       lat_map (Double): Matrix representing the LAT map.

function lat_map = plot_lat_relative_map(lat,n_grid_1d)

    lat = lat * 1000; %LATs to ms
    
    % Substract minimum value to all LATs
    lat_relative = zeros(1,length(lat));
    for i=1:length(lat)
        lat_relative(i) = lat(i) - min(lat);
    end
    
    lat_map=[];
    for i = 1:n_grid_1d:length(lat_relative)
        lat_map = [lat_map; lat_relative(i:i+(n_grid_1d-1))];
    end
    
    %Plot the map
    figure
    imagesc(lat_map);
    colormap autumn
    title('Relative LATs (ms)','FontSize',16)
    colorbar('eastoutside')
    for row = 1:n_grid_1d
        for col = 1:n_grid_1d
            label = num2str(lat_map(row,col),'%.1f');
            text(col,row,label,'HorizontalAlignment','center','FontSize',14,'FontWeight','bold','Color','k')
        end
    end
    ax=gca;
    set(gca,'XTickLabel',[])
    set(gca,'YTickLabel',[])
    set(gcf,'color','w')
end
