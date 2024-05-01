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
% Description: Function to compute the Local Activation Times (LATs).
% *************************************************************************
%
% COMPUTE_LATS computes the Local Activation Times using the classic 
% method: maximum negative slope of unipolar EGMs
%
%   lat = COMPUTE_LATS(u_egm,sampling_freq,n_grid_2d)
%
%   Parameters:
%       u_egm (Double): Unipolar electrograms.
%       sampling_freq (Double): Sampling frequency in Hz.
%       n_clique_2d (Unsigned Integer): Total number of cliques.
%
%   Returns:
%       lat (Double): Vector containing the LATs in seconds.

function lat = compute_lats(u_egm,sampling_freq,n_grid_2d)

    lat = [];
    du_egm = -gradient(u_egm);
    for i=1:n_grid_2d
        du_norm = du_egm(i,:) ./ max(du_egm(i,:));
        [pks,locs] = findpeaks(du_norm,'MinPeakHeight',0.5);
        [~,indx] = max(pks);
        lat = [lat locs(indx)/sampling_freq];
    end
end
