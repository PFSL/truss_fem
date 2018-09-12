function [nodes, elem, bc] = input_truss_0()

%% node definition
% [node_number, x_coord, y_coord]
nodes = [
    1, 0, 0;
    2, 1, 0;
    3, 2, 0;
    4, 3, 0];

%% physical properties
% E1 = 200e9;   % Young
% A1 = .0025;   % Area
% rho1 = 7860;  % Density
E1 = 4;     % Young
A1 = 1;    % Area
rho1 = 1;   % density

E2 = 2;     % Young
A2 = 1;    % Area
rho2 = 1;   % density

E3 = 6;     % Young
A3 = 1;    % Area
rho3 = 3;   % density

%% element definition
% [element_number, initial_node, final_node, Young, Area, Density]
elem = [
    1, 1, 2, E1, A1, rho1;
    2, 2, 3, E2, A2, rho2;
    3, 3, 4, E3, A3, rho3;
    ];

%% boundary conditions
% [node_number, x_dof, y_dof] --> 0=released | 1=fixed
bc = [
    1, 1, 1;
    2, 0, 1;
    3, 0, 1;
    4, 1, 1];

end