function [nodes, elem, bc] = input_truss_1()

%% node definition
% [node_number, x_coord, y_coord]
nodes = [
    1, 0, 0;
    2, 1, 0;
    3, 0, 1;
    4, 1, 1;
    5, 2, 0];

%% physical properties
% E1 = 200e9;   % Young
% A1 = .0025;   % Area
% rho1 = 7860;  % Density
E1 = 1;     % Young
A1 = 10;    % Area
rho1 = 1;   % density

%% element definition
% [element_number, initial_node, final_node, Young, Area, Density]
elem = [
    1, 1, 2, E1, A1, rho1;
    2, 2, 3, E1, A1, rho1;
    3, 3, 4, E1, A1, rho1;
    4, 2, 4, E1, A1, rho1;
    5, 2, 5, E1, A1, rho1;
    6, 4, 5, E1, A1, rho1;
    ];

%% boundary conditions
% [node_number, x_dof, y_dof] --> 0=released | 1=fixed
bc = [
    1, 1, 1;
    3, 1, 1];

end