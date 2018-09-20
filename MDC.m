function [acc, vel, des] = MDC(nt, dt, K, M, C, Force, acc, vel, des, ngl, elem, nodes, bc, nnel)
         
%% time marching scheme using central difference method
% reference taked on Bathe's book - Finite Element Procedures in
% Engineering Analysis

% use of terms just because it was easy to check for errors
a0 =  (1./(dt^2))*M + (1./2*dt)*C;
a1 = ((2./(dt^2))*M - K);
a2 = (-(1./(dt^2))*M + (1./(2*dt))*C);

% initial conditions
vel0 = vel(:,1);
des0 = des(:,1);

% evaluation of acceleration at time 0
acc0 = pinv(M)*(Force(:,1) - C*vel0 - K*des0);

% negative displacement to evaluate the displacement in time 1
desneg = des0 - dt*vel0 + ((dt^2)/2.)*acc0;

% setting displacements in order to automate operations - at the final of
% the routine removes the first line (corresponds to negative time
% displacement)
acc(:,1) = acc0;
des(:,1) = des0;
des(:,2) = desneg;

for it=2:nt
    % displacement update
    des(:,it+1) = a0 \ (a1*des(:,it) + a2*des(:,it-1) + Force(:,it));
    
    % velocity update
    vel(:,it) = (1./(2.*dt))*(des(:,it+1) - des(:,it-1));
    
    % acceleration update
    acc(:,it) = (1./(dt^2))*(des(:,it+1) - 2*des(:,it) + des(:,it-1));
end

% % last acceleration update
% acc(:,nt+1) = (1./(dt^2))*(des(:,nt) - 2*des(:,nt-1) + des(:,nt-2));
% 
% % last velocity update
% vel(:,nt+1) = (1./(2.*dt))*(des(:,nt) - des(:,nt-2));

% removing the last line of displacement that was evaluated at time (nt+1)
des(:,nt) = [];












% 
% 
% 
% 
% 
% %% time marching scheme using central difference method
% % reference taked on Rao's book - Mechanical vibrations
% % important note: damping coeficients does not generates the same response
% % than used in previous method (with was not central difference but one
% % based on a linear time operator
% 
% % initial conditions
% vel0 = vel(:,1);
% des0 = des(:,1);
% 
% % evaluation of acceleration at time 0
% acc0 = pinv(M)*(Force(:,1) - C*vel0 - K*des0)
% 
% % negative displacement to evaluate the displacement in time 1
% desneg = des0 - dt*vel0 + ((dt^2)/2.)*acc0;
% 
%  % setting displacements in order to automate operations - at the final of
%  % the routine removes the first line (corresponds to negative time
%  % displacement)
% des(:,1) = desneg;
% des(:,2) = des0;
% 
% 
% for it=3:(nt + 1)
%     
%     % use of terms just because it was easy to check for errors
%     termo1 = (1./(dt^2))*M + (1./2*dt)*C;
%     termo2 = Force(:,it-1) - (K - (2./(dt^2))*M)*des(:,it-1);
%     termo3 = ((1./(dt^2))*M - (1./2*dt)*C)*des(:,it-2);
%     
%     % displacement update
%     des(:,it) = termo1\(termo2 - termo3);
%     
%     % acceleration update
%     acc(:,it-1) = (1./(dt^2))*(des(:,it) - 2*des(:,it-1) + des(:,it-2));
%     
%     % velocity update
%     vel(:,it-1) = (1./(2.*dt))*(des(:,it) - des(:,it-2));
%     
% end
% 
% % last acceleration update
% acc(:,nt+1) = (1./(dt^2))*(des(:,nt) - 2*des(:,nt-1) + des(:,nt-2));
% 
% % last velocity update
% vel(:,nt+1) = (1./(2.*dt))*(des(:,nt) - des(:,nt-2));
% 
% % removing the first line with was used to put the negative time for first
% % iteration
% des(:,1) = [];
% vel(:,1) = [];
% acc(:,1) = [];

end