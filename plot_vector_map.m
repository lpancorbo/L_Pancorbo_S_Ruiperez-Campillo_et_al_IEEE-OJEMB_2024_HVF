% *************************************************************************
% QCEP ITACA UPV
% Vector Field Heterogeneity
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
% Description: Function to create a vector map representing the wave
%              propagation under the catheter grid.
% *************************************************************************
%
% PLOT_VECTOR_MAP takes a vector containing all the angles of propagation 
% and plots a vector map of the direction of propagation
%
%   [X,Y,U,V] = PLOT_VECTOR_MAP(angle,n_clique_1d)
%
%   Parameters:
%       angle (Double): Angle of direction of propagation of each clique.
%       n_clique_1d (Unsigned Integer):  Number of rows of the cliques
%
%   Returns:
%       X,Y (Double): Axis points of the vector field
%       U,V (Double): Vector components of the vector field

function [X,Y,U,V] = plot_vector_map(angle,n_clique_1d)

    [X,Y] = meshgrid(1:n_clique_1d,1:n_clique_1d);
    U = [];
    V = [];
    for i = length(angle):-n_clique_1d:1
        U = [U; cos(angle(i-(n_clique_1d-1):i))];
        V = [V; sin(angle(i-(n_clique_1d-1):i))];
    end
    
    figure
    quiver(X,Y,U,V,0.3,'k');
    for i=1:n_clique_1d-1
        xline(i+0.5)
        yline(i+0.5)
    end
    axis([0.5 (n_clique_1d + 0.5) 0.5 (n_clique_1d + 0.5)])
    title('Propagation Map','FontSize',16)
    ax = gca;
    ax.XTickLabel = [];
    ax.YTickLabel = [];
    set(gcf,'color','w')

end
