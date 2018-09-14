function [acc, vel, des] = NEWMARK(nt, dt, K, M, C, Force, acc, vel, des, ngl, elem, nodes, bc, nnel)
         
%% time marching scheme using Newmark method
% reference taked on Rao's book - Mechanical vibrations
% important note: damping coeficients does not generates the same response
% than used in previous method (with was not central difference but one
% based on a linear time operator

% newmark parameters
beta  = 1/2;                % related to numerical damping (1/2 has no damping)
% alpha = 1/4*(beta-1/2)^2;
alpha = 1/2;


% initial conditions
vel0 = vel(:,1);
des0 = des(:,1);

% evaluation of acceleration at time 0
acc0 = pinv(M)*(Force(:,1) - C*vel0 - K*des0);

des(:,1) = des0;
vel(:,1) = vel0;
acc(:,1) = acc0;


for it=2:(nt)
    
    % use of terms just because it was easy to check for errors
    termo1 = (1./(alpha*(dt^2)))*M + (beta/(alpha*dt))*C + K;
    termo2 = Force(:,it) + M*((1./(alpha*(dt^2)))*des(:,it-1) + (1./(alpha*dt))*vel(:,it-1) + (1./(2*alpha)-1)*acc(:,it-1));
    termo3 = C*((beta/(alpha*dt))*des(:,it-1) + ((beta/alpha)-1)*vel(:,it-1));
    termo4 = ((beta/alpha)-2)*(dt/2)*acc(:,it-1);
    
    % displacement update
    des(:,it) = termo1\(termo2 + termo3 + termo4);
    
    % acceleration update
    acc(:,it) = (1./(alpha*(dt^2)))*(des(:,it) - des(:,it-1)) - (1./(alpha*dt)*vel(:,it-1) - (1./(2*alpha)-1.)*acc(:,it-1));
    
    % velocity update
    vel(:,it) = vel(:,it-1) + (1.-beta)*dt*acc(:,it-1) + beta*dt*acc(:,it);
    
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