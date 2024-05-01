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
% Description: Function to compute finite differences of a vector field.
% *************************************************************************
%
% FINITE_DIFFERENCE takes one of the components of the vector field and 
% computes finite differences with the neighboring elements.
%
%   [px,py,pd1,pd2] = FINITE_DIFFERENCE(u,x,y)
%
%   Parameters:
%       u (Double): Horizontal or vertical component of the vector field.
%       x,y (Double): Matrices containing the meshgrid points.
%
%   Returns:
%       px (Double): Element (i,j) contains the mean absolute value of the
%           finite differences with (i,j+1) and (i,j-1).
%       py (Double): Element (i,j) contains the mean absolute value of the
%           finite differences with (i+1,j) and (i-1,j).
%       pd1 (Double): Element (i,j) contains the mean absolute value of the
%           finite differences with (i-1,j+1). and (i+1,j-1).
%       pd2 (Double): Element (i,j) contains the mean absolute value of the
%           finite differences with (i-1,j-1). and (i+1,j+1).

function [px,py,pd1,pd2] = finite_difference(u,x,y)

    hx = x(1,:);
    hy = y(:,1);
    
    px = [];
    py = [];
    pd1 = [];
    pd2 = [];
    for i = 1:length(hx)
        for j = 1:length(hy)
    
            % Finite differences in x
            single_sided_x = [];
            if (j+1)<=length(hy)
                forward_x = (u(i,j+1) - u(i,j)) / (hx(j+1) - hx(j));
                single_sided_x = [single_sided_x forward_x];
            end
            if (j-1)>0
                backward_x = (u(i,j) - u(i,j-1)) / (hx(j) - hx(j-1));
                single_sided_x = [single_sided_x backward_x];
            end
            px(i,j) = mean(abs(single_sided_x));
    
            % Finite differences in y
            single_sided_y = [];
            if (i+1)<=length(hy)
                forward_y = (u(i+1,j) - u(i,j)) / (hy(i+1) - hy(i));
                single_sided_y = [single_sided_y forward_y];
            end
            if (i-1)>0
                backward_y = (u(i,j) - u(i-1,j)) / (hy(i) - hy(i-1));
                single_sided_y = [single_sided_y backward_y];
            end
            py(i,j) = mean(abs(single_sided_y));
    
    
            % Finite differences along the first diagonal
            single_sided_d1 = [];
            if ((i-1)>0) && ((j+1)<=length(hx))
                forward_d1 = (u(i-1,j+1) - u(i,j)) / (hx(j+1) - hx(j));
                single_sided_d1 = [single_sided_d1 forward_d1];
            end
            if ((i+1)<=length(hy)) && ((j-1)>0)
                backward_d1 = (u(i,j) - u(i+1,j-1)) / (hx(j) - hx(j-1));
                single_sided_d1 = [single_sided_d1 backward_d1];
            end
    
            if isempty(single_sided_d1)==1
                pd1(i,j) = 0;
            else
                pd1(i,j) = mean(abs(single_sided_d1));
            end
            
            % Finite differences along the second diagonal
            single_sided_d2 = [];
            if ((i-1)>0) && ((j-1)>0)
                backward_d2 = (u(i,j) - u(i-1,j-1)) / (hx(j) - hx(j-1));
                single_sided_d2 = [single_sided_d2 backward_d2];
            end
            if ((i+1)<=length(hy)) && ((j+1)<=length(hx))
                forward_d2 = (u(i+1,j+1) - u(i,j)) / (hx(j+1) - hy(j));
                single_sided_d2 = [single_sided_d2 forward_d2];
            end
    
            if isempty(single_sided_d2)==1
                pd2(i,j) = 0;
            else
                pd2(i,j) = mean(abs(single_sided_d2));
            end
    
        end
    end
end
