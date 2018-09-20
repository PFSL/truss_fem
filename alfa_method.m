function [acc, vel, des] = alfa_method(nt, dt, K, M, C, Force, acc, vel, des, ngl, elem, nodes, bc, nnel)

% parameter choosen to meet the generalized HHT-alpha method
gama  = 0.05;
alfa  = .25*(1 + gama)^2;
delta = .5 + gama;
alfaf = gama;
alfam = 0;

a0 = (1-alfam)/(alfa*dt^2);
a1 = ((1-alfaf)*delta)/(alfa*dt);
a2 = a0*dt;
a3 = (1-alfam)/(2*alfa) - 1;
a4 = ((1-alfaf)*delta)/alfa - 1;
a5 = (1-alfaf)*(delta/(2*alfa)-1)*dt;


% initial conditions
vel0 = vel(:,1);
des0 = des(:,1);

% evaluation of acceleration at time 0
acc0 = pinv(M)*(Force(:,1) - C*vel0 - K*des0);

des(:,1) = des0;
vel(:,1) = vel0;
acc(:,1) = acc0;


A0 = inv(a0*M + a1*C + (1-alfaf)*K);


for it=1:(nt-1)
    
    % displacement update
    
    
    des(:,it+1) = A0*((1-alfaf)*Force(:,it+1) + alfaf*Force(:,it) - alfaf*K*des(:,it) + M*(a0*des(:,it) + a2*vel(:,it) + a3*acc(:,it)) + C*(a1*des(:,it) + a4*vel(:,it) + a5*acc(:,it)));
    
    
%     des(:,it+1) = A0*(Force(:,it+1) + M*(a0*des(:,it) + a2*vel(:,it) + a3*acc(:,it)) +C*(a1*des(:,it) + a4*vel(:,it) + a5*acc(:,it)));

    % velocity update
    vel(:,it+1) = a1*(des(:,it+1) - des(:,it)) - a4*vel(:,it) - a5*acc(:,it);

    % acceleration update
    acc(:,it+1) = a0*(des(:,it+1) - des(:,it)) - a2*vel(:,it) - a3*acc(:,it);
    
    
end


end