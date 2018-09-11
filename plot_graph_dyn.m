function plot_graph_dyn(nodes, elem, ngl, magnif, des, acc, vel, nnel, nt)

%% plot structure in motion for each time step

% coordinates
x = nodes(:,2);
y = nodes(:,3);

figure(3);
% set limits for truss example
set(gca, 'XLim', [-.25,2.25], 'YLim', [-1.5, 2.5]);

% plot initial truss (in time zero)
color = 'b';
s = line(x', y', 'Color', color, 'LineWidth', 1);

% refresh positions with magnification
for t=1:nt
    % refresh coordinates at time step
    [elemx, elemy] = plot_truss_def(nodes, elem, des(:,t), ngl, magnif);
    s.XData = elemx;    % replace surface x values
    s.YData = elemy;    % replace surface x values
    
    drawnow;
end
end



function [rnewx, rnewy] = plot_truss_def(nodes, elem, u, ngl, magnif)

%% aux function to draw new structures at each time step 
x = nodes(:,2);
y = nodes(:,3);

[nelem, lixo] = size(elem);
[nnodes, lixo] = size(nodes);

for i=1:nnodes
    ux = i*ngl - 1;
    uy = i*ngl;
    
    newx(i) = x(i) + magnif*u(ux);
    newy(i) = y(i) + magnif*u(uy);
end

for e=1:nelem
    nx(e,:) = [newx(elem(e,2)) newx(elem(e,3))];
    ny(e,:) = [newy(elem(e,2)) newy(elem(e,3))];
end

[l,c] = size(nx);

rnewx = reshape(nx',[1,l*c]);
rnewy = reshape(ny',[1,l*c]);
end

