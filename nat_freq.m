function [freqn, modes] = nat_freq(nodes, elem, bc, ti, tf, dt, F, alfa_damp, beta_damp, ngl, nnos, sdof, nnel, N, nelem)

%% mount the system of equations using FEM
[Mef, Cef, Kef, Fef, iddof, indexnodof2, nidof, sdof, ngl] = truss_FEM(nodes, elem, bc, alfa_damp, beta_damp, N, F, nelem, ngl, sdof, nnos, nnel);

%% initial condition
vel = zeros(nidof,1);   % velocity
des = zeros(nidof,1);   % displacement
acc = zeros(nidof,1);   % acceleration


[f1,f2] = eig(Kef)

freqn = sqrt(inv(Mef)*Kef)/(2*pi)


[f1,f2] = eig(Mef,Kef)

freqq = sqrt(f2./(2*pi))



end