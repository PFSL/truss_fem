function [des, acc, vel, indexbc] = truss_dyn_dfc(nodes, elem, bc, ti, tf, dt, F, alfa_damp, beta_damp, ngl, nnos, sdof, nnel, N, nelem)

%% memory allocation
K = zeros(sdof,sdof);   % stiffness matrix
M = zeros(sdof,sdof);   % mass matrix
acc = zeros(sdof,N);    % acceleration vector
vel = zeros(sdof,N);    % velocity vector 
des = zeros(sdof,N);    % displacement vector

%% global system mounting
[K, M] = global_sys(K, M, nodes, elem, nelem, ngl, nnel);

%% damping matrix using proportional damping
C = alfa_damp.*M + beta_damp.*K;

%% initial condition
vel(:,1) = zeros(sdof,1);   % velocity
des(:,1) = zeros(sdof,1);   % displacement

%% central difference for time integration
[acc, vel, des, indexbc] = dif_central(N, dt, K, M, C, F, acc, vel, des, ngl, elem, nodes, bc, nnel);

end