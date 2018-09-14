function [des, acc, vel, indexbc] = truss_dyn_nmk(nodes, elem, bc, ti, tf, dt, F, alfa_damp, beta_damp, ngl, nnos, sdof, nnel, N, nelem)

%% mount the system of equations using FEM
[Mef, Cef, Kef, Fef, iddof, indexnodof2, nidof, sdof, ngl] = truss_FEM(nodes, elem, bc, alfa_damp, beta_damp, N, F, nelem, ngl, sdof, nnos, nnel);

%% initial condition
vel = zeros(nidof,1);   % velocity
des = zeros(nidof,1);   % displacement
acc = zeros(nidof,1);   % acceleration

%% newmark method for time integration
[acc, vel, des] = NEWMARK(N, dt, Kef, Mef, Cef, Fef, acc, vel, des, ngl, elem, nodes, bc, nnel);

end