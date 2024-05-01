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
% IEEE Open Journal of Engineering in Medicine and Biology (2023).
%
% Description: Function to replicate the Spatial Inhomogeneity (SI) index
% introduced by Lammers et al. 
% Algorithm based on the work: W. J. Lammers, et al. "Quantification of 
% spatial inhomogeneity in conduction and initiation of reentrant atrial 
% arrhythmias." American Journal of Physiology-Heart and Circulatory 
% Physiology (1990).
% *************************************************************************
%
% COMPUTE_SI computes the Inhomogeneity index from the activation map.
%
%   si = COMPUTE_SI(lat_map,n_grid_1d)
%
%   Parameters:
%       lat_map (Double): Matrix representing the LAT map.
%       n_grid_1d (Unsigned Integer): Number of rows of the catheter.
%
%   Returns:
%       si (Double): Spatial Inhomogeneity (SI) Index

function si = compute_si(lat_map,n_grid_1d)

    phase_map = zeros(n_grid_1d-1,n_grid_1d-1);
    count = 0;
    N = n_grid_1d;
    exclude = [N:N:N*N, (N*N - N + 1):N*N];
    for i = 1:n_grid_1d
        for j = 1:n_grid_1d
            count = count + 1;
            if ~ismember(count, exclude)
                % Extract the 2x2 group
                group = lat_map(i:i+1,j:j+1);
                % Calculate the differences between the elements in the group
                diffs = [abs(group(1,1)-group(1,2)), abs(group(1,2)-group(2,2)), abs(group(2,2)-group(2,1)), abs(group(2,1)-group(1,1))];
                % Assign the maximum difference to the "phase" variable
                phase = max(diffs);
                % Store the "phase" value in the "phase_map" matrix
                phase_map(i,j) = phase;
            end
        end
    end

    phase_diffs = reshape(phase_map,[1 numel(phase_map)]);
    P50 = median(phase_diffs);
    P5 = prctile(phase_diffs,5);
    P95 = prctile(phase_diffs,95);
    si = (P95-P5)/P50;
end

