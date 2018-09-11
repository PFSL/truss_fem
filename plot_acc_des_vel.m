function plot_acc_des_vel(nodes, elem, ngl, magnif, des, acc, vel, nnel, t, nodal_val)

%% plot values of acceleration, velocity and displacement for a single dof

% number of dofs obtained
% if more nodes are included, so must modify color setting to change the
% color for each dof observed
[~,nn_val] = size(nodal_val);

figure(2);    
for i=1:nn_val

    no = nodal_val(i); % dof
    
    % plot displacements value in time
    subplot(3,1,1); plot(t,des(no,:),'b');
    xlabel('Time (seconds)')
    ylabel('Displacement (m)')
    hold on
    
    % plot velocities value in time
    subplot(3,1,2); plot(t,vel(no,:),'r');
    xlabel('Time (seconds)')
    ylabel('Speed (m/s)')
    hold on
    
    % plot accelerations value in time
    subplot(3,1,3); plot(t,acc(no,:),'k');
    xlabel('Time (seconds)')
    ylabel('Acceleration (m/s^2)')
    hold on
    
end
end