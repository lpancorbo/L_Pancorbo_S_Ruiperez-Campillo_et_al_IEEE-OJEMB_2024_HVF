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
% Description: Function to compute the Vector Field Heterogeneity (VFH)
% *************************************************************************
%
% COMPUTE_VFH computes the vector heterogeneity for each clique. 
% The VFH metric is calculated as the average.
%
%   vfh = COMPUTE_VFH(angle,n_clique_1d)
%
%   Parameters:
%       angle (Double): Angle of direction of propagation of each clique.
%       n_clique_1d (Unsigned Integer):  Number of rows of the cliques
%
%   Returns:
%       vfh (Double): VFH value of the vector map.

function vfh = compute_vfh(angle,n_clique_1d)

    [x,y] = meshgrid(1:n_clique_1d,1:n_clique_1d);
    u = [];
    v = [];
    for i = length(angle):-n_clique_1d:1
        u = [u; cos(angle(i-(n_clique_1d-1):i))];
        v = [v; sin(angle(i-(n_clique_1d-1):i))];
    end
    
    %  Differences between neighbouring vectors in the field taken in the
    %  vertical (y), horizontal (x), and diagonal (d) directions.
    [px,py,pd1,pd2] = finite_difference(u,x,y);
    [qx,qy,qd1,qd2] = finite_difference(v,x,y);
    
    % x_score quantifies how different a vector is w.r.t. its 
    % horizonal neighbours.
    x_score = sqrt(px.^2 + qx.^2);
    y_score = sqrt(py.^2 + qy.^2); % Idem vertically
    d1_score = sqrt(pd1.^2 + qd1.^2); % Idem positive diagonal.
    d2_score = sqrt(pd2.^2 + qd2.^2); % Idem negative diagonal.
    
    % Chi is the normalization constant
    chi = (4 + 2*sqrt(2)) * ones(n_clique_1d,n_clique_1d);
    chi(1,1) = 4 + sqrt(2);
    chi(1,n_clique_1d) = 4 + sqrt(2);
    chi(n_clique_1d,1) = 4 + sqrt(2);
    chi(n_clique_1d,n_clique_1d) = 4 + sqrt(2);
    
    sum_weighted = x_score + y_score + ((1/sqrt(2))*d1_score) + ((1/sqrt(2))*d2_score);
    score_matrix = sum_weighted ./ chi;
    
    vfh = mean(score_matrix,'all');
end
