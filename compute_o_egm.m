% *****************************************************************************
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
% Description: Function that computes omnipolar electrograms.
% *************************************************************************
%
% COMPUTE_O_EGM takes the matrix containing all bipolar EGMs and 
% rotates them in the direction of propagation to get the omnipolar EGMs.
%
%   o_egm = COMPUTE_O_EGM(b_egm, angle,n_clique_2d)
%
%   Parameters:
%       b_egm: (Double): Bipolar electrogram.
%       angle (Double): Angle of direction of propagation of each clique.
%       n_clique_2d (Unsigned Integer): Total number of cliques.
%
%   Returns:
%       o_egm (Double): Omnipolar electrogram.

function o_egm = compute_o_egm(b_egm, angle,n_clique_2d)

    o_egm = [];
    clique = 0;
    for i=1:2:(n_clique_2d*2)
        clique = clique + 1;
        bx = b_egm(i,:);
        by = b_egm(i+1,:);
            if angle(clique) < 0
                rot_angle = 2*pi + angle(clique);
            else
                rot_angle = angle(clique);
            end
        rotation=[cos(-rot_angle) -sin(-rot_angle);...
                  sin(-rot_angle) cos(-rot_angle)];
        rotated_b_egm = rotation * [b_egm(i,:); b_egm(i+1,:)];
        o_egm = [o_egm; rotated_b_egm];
end
