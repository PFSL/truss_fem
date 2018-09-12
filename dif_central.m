function [acc, vel, des] = dif_central(nt, dt, K, M, C, Force, acc, vel, des, ngl, elem, nodes, bc, nnel)

%% time marching scheme using central difference method

for it=1:nt-1
    % load at time step
    F = Force(:,it);
    
    
    % acceleration
    % formula considers at fist time step the initial condition
    acc(:,it) = M\(F - C*vel(:,it) - K*des(:,it));
    
    % boundary conditions applied
    [nbc, ~] = size(bc);
    
%     k = 0;
%     for i=1:nbc
%         ini = (bc(i,1)-1)*ngl;          % find position at vector
%         
%         for j=1:ngl
%             if bc(i,j+1) == 1
%                 k = k + 1;
%                 
%                 indexbc(k) = ini+j;
%                 acc(ini + j,it) = 0;    % place zero to fixed dof
%                 
%             end
%         end    
%     end
    
    % evaluate velocity based on acceleration
    vel(:,it+1) = vel(:,it) + acc(:,it)*dt;
    
    % evaluate displacement based on velocity
    des(:,it+1) = des(:,it) + vel(:,it+1)*dt;    
end

% prescribe the last acceleration step
acc(:,it+1) = acc(:,it);

end