% *************************************************************************
% QCEP ITACA UPV
% Simulate Vector Maps
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
% Description: Function to simulate a propagation vector map with a given
% level of heterogeneity/disorganisation
% *************************************************************************
%
% SIMULATE_VECTOR_MAP takes a vector containing an angle interval 
% and creates a vector map with random angles contained in such interval.
%
%   angle = SIMULATE_VECTOR_MAP(angle_interval,n_clique_1d)
%
%   Parameters:
%       angle_interval (Double): Angle interval limits (deg).
%       n_clique_1d (Unsigned Integer):  Number of rows of the cliques
%
%   Returns:
%       angle (Double): Angle of each vector with the horizontal axis.

function angle = simulate_vector_map(angle_interval,n_clique_1d)
    angle_interval = deg2rad(angle_interval);
    n_clique_2d = n_clique_1d^2;
    subinterval = linspace(angle_interval(1),angle_interval(2),n_clique_2d+1);
    angle = [];
    for i=1:n_clique_2d
        rand_angle = unifrnd(subinterval(i), subinterval(i+1), 1, 1);
        angle = [angle rand_angle];
    end
    angle = angle(randperm(length(angle)));
end
