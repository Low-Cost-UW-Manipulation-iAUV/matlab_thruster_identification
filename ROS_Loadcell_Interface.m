function ROS_Loadcell_Interface
clc
clear all

%% Settings
meas_duration = 300; % Duration of measurement in seconds
update_rate = 50; % update rate

%% Global data

global message_data;

message_data(meas_duration * update_rate).sequence = 0;
message_data(meas_duration * update_rate).value = 0;

global count;
count = 1;

%% Start the nodes
node = rosmatlab.node('Matlab', '164.11.72.41',11311');

subscriber = rosmatlab.subscriber('/thruster_ident_force','geometry_msgs/Vector3', 20,node);

subscriber.setOnNewMessageListeners({@storeData});
disp('started');

    function storeData(message)
        %% Thruster Identification ROS interface
        % This will receive messages from ros running on the BBB and do the
        % identification on them
        
        
        message_data(count).sequence = message.getY();
        %message_data(count).Header.stamp = message.getHeader.getStamp();
        
        message_data(count).value = message.getX();
        
        if count == (meas_duration * update_rate)
            save('calibrate_vertical.mat', 'message_data');
            clear subscriber;
            disp('finished');
        end
        count = count + 1;
    end

str = input('Enter any key to terminate','s');

end