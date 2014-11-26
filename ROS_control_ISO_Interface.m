function ROS_control_ISO_Interface
%Subscribes to the command outputs of the hardware interface test_robot, simulates a system and publishes the
%corresponding data back to the hardware interface

clc
clear all


%% Settings
meas_duration = 300; % Duration of measurement in seconds
update_rate = 50; % update rate


%% data
message_data(meas_duration * update_rate).value = 0;
count = 1;

%% Integration of commands - test
accumulator = 0;

%% Start the nodes
node = rosmatlab.node('Matlab', '164.11.72.41',11311');

publisher = rosmatlab.publisher('/test_robot/in1', 'geometry_msgs/Vector3', node);

subscriber = rosmatlab.subscriber('/test_robot/out','geometry_msgs/Vector3', 20,node);

subscriber.setOnNewMessageListeners({@storeData});


disp('started');

    function storeData(message)
        %% Thruster Identification ROS interface
        % This will receive messages from ros running on the BBB and do the
        % identification on them
        
        message_data(count).value = message.getX();
        accumulator = accumulator + (message.getX()/1000);
        msg = rosmatlab.message('geometry_msgs/Vector3', node);
        msg.setX(accumulator);
        msg.setY(0);
        msg.setZ(0);
        publisher.publish(msg);
        
        
%         if count == (meas_duration * update_rate)
%             save('ROS_control_ISO_response.mat', 'message_data');
%             clear subscriber;
%             disp('finished');
%         end
        count = count + 1;
    end

str = input('Enter any key to terminate','s');


end