clear all; clc

%% input of a simple truss
[nodes, elem, bc] = input_truss_1();

% define size of the problem
[nnos,~] = size(nodes); % number of nodes
[nelem,~] = size(elem); % number of elements
ngl = 2;                % number of degrees of freedom (dof) per node
sdof = nnos*ngl;        % total number of dof
nnel = 2;               % number of nodes per element

% define time properties
Fs = 50;            % Sample frequency (Hz)
dt = 1/Fs;          % time intervl (sec)
ti = 0;             % initial time
tf = 150;           % final time

t = [ti:dt:tf+dt]';    % time vector (tf+dt in order to consider initial time)
N = size(t,1) - 1;     % step times (minos 1 in order to not count initial condition)

%% input truss design check
plot_graph(nodes, elem, ngl)

%% load vector (varying in time)
F = zeros(sdof,N);

% for the specifc case
F(10,:) = -.5;

%% proportional damping coefficients
alfa_damp = .01;
beta_damp = .015;

N

%% numerical solver - FEM with central diference method
[des_dfc, acc_dfc, vel_dfc, indexbc] = truss_dyn_dfc(nodes, elem, bc, ti, tf, dt, F, alfa_damp, beta_damp, ngl, nnos, sdof, nnel, N, nelem);

% plot acceleration, displacement and velocity of a single dof
magnif = 1;         % magnification factor
nodal_val = [10];   % dof to be ploted
plot_acc_des_vel(nodes, elem, ngl, magnif, des_dfc, acc_dfc, vel_dfc, nnel, t, nodal_val)

% %% numerical solver - FEM with newmark method
% [des_dfc, acc_dfc, vel_dfc, indexbc] = truss_dyn_dfc(nodes, elem, bc, ti, tf, dt, F, alfa_damp, beta_damp);
% 
% % plot results
% % plot acceleration, displacement and velocity of a single dof
% magnif = 1;         % magnification factor
% nodal_val = [10]    % dof to be ploted
% plot_acc_des_vel(nodes, elem, ngl, magnif, des_dfc, acc_dfc, vel_dfc, nnel, t, nodal_val)
% 
% % % % plot structure motion
% % % plot_graph_dyn(nodes, elem, ngl, magnif, des, acc, vel, nnel, N)
