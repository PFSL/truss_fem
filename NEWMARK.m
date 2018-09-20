function [acc, vel, des] = NEWMARK(nt, dt, K, M, C, Force, acc, vel, des, ngl, elem, nodes, bc, nnel)
         
%% time marching scheme using Newmark method
% reference taked on Rao's book - Mechanical vibrations
% important note: damping coeficients does not generates the same response
% than used in previous method (with was not central difference but one
% based on a linear time operator

% newmark parameters
delta  = 1/2;                % related to numerical damping (1/2 has no damping)
alfa   = 1/6;


% initial conditions
vel0 = vel(:,1);
des0 = des(:,1);

% evaluation of acceleration at time 0
acc0 = pinv(M)*(Force(:,1) - C*vel0 - K*des0);

des(:,1) = des0
vel(:,1) = vel0
acc(:,1) = acc0



a0 = 1./(alfa*(dt^2));
a1 = delta/(alfa*dt);
a2 = 1./(alfa*dt);
a3 = (1./(2*alfa))-1;
a4 = (delta/alfa)-1;
a5 = (dt/2)*((delta/alfa)-2);
a6 = dt*(1-delta);
a7 = delta*dt;


A0 = inv(a0*M + a1*C + K);



for it=1:(nt-1)
    
    % displacement update
    des(:,it+1) = A0*(Force(:,it+1) + M*(a0*des(:,it) + a2*vel(:,it) + a3*acc(:,it)) +C*(a1*des(:,it) + a4*vel(:,it) + a5*acc(:,it)));

    % velocity update
    vel(:,it+1) = a1*(des(:,it+1) - des(:,it)) - a4*vel(:,it) - a5*acc(:,it);

    % acceleration update
    acc(:,it+1) = a0*(des(:,it+1) - des(:,it)) - a2*vel(:,it) - a3*acc(:,it);
    
    
end

% % last acceleration update
% acc(:,nt+1) = (1./(dt^2))*(des(:,nt) - 2*des(:,nt-1) + des(:,nt-2));
% 
% % last velocity update
% vel(:,nt+1) = (1./(2.*dt))*(des(:,nt) - des(:,nt-2));

% % removing the first line with was used to put the negative time for first
% % iteration
% des(:,1) = [];
% vel(:,1) = [];
% acc(:,1) = [];

end