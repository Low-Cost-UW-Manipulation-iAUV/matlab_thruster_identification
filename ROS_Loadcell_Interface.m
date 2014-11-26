function ROS_Loadcell_Interface
clc
clear all

%% Settings
meas_duration = 300; % Duration of measurement in seconds
update_rate = 50; % update rate


count = 1;

%% Start the nodes
node = rosmatlab.node('Matlab', '164.11.72.41',11311');

subscriber = rosmatlab.subscriber('/test_robot/out','geometry_msgs/Vector3', 20,node);

subscriber.setOnNewMessageListeners({@storeData});
disp('started');
global message_data;
    function storeData(message)
        %% Thruster Identification ROS interface
        % This will receive messages from ros running on the BBB and do the
        % identification on them
        
        
        message_data(count).demand = message.getX();
        %message_data(count).Header.stamp = message.getHeader.getStamp();
        
        message_data(count).response = message.getY();
        
        count + 1;
    end

str = input('Enter any key to terminate','s');
            save('calibrate_vertical.mat', 'message_data');

end