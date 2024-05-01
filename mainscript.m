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
% Description: This main script performs the following objectives: 
% Processing of unipolar signals to estimate the propagation map,
% compute VFH metric, compute SI index, and generate simulated 
% propagation maps to test the VFH metric.
% *************************************************************************

%% Propagation vector maps from unipolar signals

% Each row of u_egm contains a unipolar EGM containing a single beat.

n_grid_1d = %INPUT ; % Number of rows of the catheter
sampling_freq = %INPUT ; % Sampling frequency in Hz
distance = %INPUT; % Interelectrode distance in m

n_grid_2d = n_grid_1d^2;
n_clique_1d = n_grid_1d - 1;
n_clique_2d = n_clique_1d^2;

b_egm = compute_b_egm(u_egm,n_grid_1d,n_grid_1d,6);

angle_estimation = compute_angle_estimation(b_egm, n_grid_1d, n_grid_1d);
o_egm = compute_o_egm(b_egm,angle_estimation,n_clique_2d);

plot_vector_map(angle_estimation,n_clique_1d);

%% Vector Field Heterogeneity (VFH)
vfh = compute_vfh(angle_estimation,n_clique_1d); % VFH metric

vfh_map = plot_vfh_map(angle_estimation,n_clique_1d);

%% Spatial Inhomogeneity Index (SI)
lat = compute_lats(u_egm,sampling_freq,n_grid_2d);
lat_map = plot_lat_relative_map(lat,n_grid_1d);

si = compute_si(lat_map,n_grid_1d); % SI index
phase_map=plot_phase_map(lat_map,n_grid_1d);
plot_phase_histogram(lat_map,n_grid_1d)

%% Simulated Propagation Maps
angle_interval = %INPUT; %Example [-50 50]
simulated_angle = simulate_vector_map(angle_interval,n_clique_1d);
plot_vector_map(simulated_angle,n_clique_1d);

% Generate simulated data
N = %INPUT ; % Number of simulations per level of disorganisation
vfh_results = vfh_simulated_data(n_clique_1d,N);
