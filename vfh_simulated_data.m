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
% Description: Function to simulate N propagation vector maps with 
% increasing levels of heterogeneity/disorganisation and apply VFH
% *************************************************************************
%
% VFH_SIMULATED_DATA simulates N vector maps and computes the VFH
%
%   vfh_results = VFH_SIMULATED_DATA(angle_interval,n_clique_1d,N)
%
%   Parameters:
%       angle_interval (Double): Angle interval limits (deg)
%       n_clique_1d (Unsigned Integer):  Number of rows of the cliques
%       N (Unsigned Integer): Number of simulated maps per angular interval
%
%   Returns:
%       vfh_results (Double): Resulting VFH values when applying the VFH
%           metric to N simulated maps for different angular intervals 
%           starting at ±1deg and from ±5deg to ±180deg in steps of 5deg

function vfh_results = vfh_simulated_data(n_clique_1d,N)
    limits = [1 5:5:180];
    vfh_results = zeros(N,length(limits));
    for j = 1:length(limits)
        angle_interval = deg2rad(limits(j)) * [-1 1];
        for i = 1:N
            simulated_angle = simulate_vector_map(angle_interval,n_clique_1d);
            vfh = compute_vfh(simulated_angle,n_clique_1d);
            vfh_results(i,j) = vfh;
        end
    end
end
