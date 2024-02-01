% function to print out characteristcs - Irene 
function dispChar(user_id)
    try
        load("user.mat","user");
    catch
        error("Error accessing the data file!")
    end
    % print out all of the characteristics
    fprintf("Your full name is: %s\n", user(user_id).name);
    fprintf("Your age is: %d\n", user(user_id).age);
    fprintf("Your gender is: %s\n", user(user_id).gender);
    fprintf("Your height is: %d\n", user(user_id).height);
    fprintf("Your hair color is: %s\n", user(user_id).hair_color);
    fprintf("Your eye color is: %s\n", user(user_id).eye_color);
    fprintf("Your intro is: %s\n\n", user(user_id).intro);
end

