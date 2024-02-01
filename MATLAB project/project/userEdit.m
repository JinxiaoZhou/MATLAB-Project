% function to edit a user in the user struct in user.mat

function userEdit(user_id)

    % test file
    if ~isfile("user.mat")
        error("Data file not present. Initialize database by creating a new user!");
    end

    %load data file
    try
        load("user.mat","user");
    catch
        error("Error accessing the data file!")
    end
    
    % user input and save file
    disp("We will now ask for your characteristics.");
    
    try
        user(user_id).user_id = user_id;
        user(user_id).name = string(input("Please enter your full name: ", "s"));
        user(user_id).age = input("Please enter your age: ");
        user(user_id).gender = string(input("Please enter your gender: ", "s"));
        user(user_id).height = input("Please enter your height (cm): ");
        user(user_id).hair_color = string(input("Please enter your hair colour: ", "s"));
        user(user_id).eye_color = string(input("Please enter your eye colour: ", "s"));
        user(user_id).intro = string(input("Please enter a short introduction,and your contact method: ", "s"));
        user(user_id).pending_match = [];

        save("user.mat","user");

    catch
        error("Error editing the user!");
    end

    fprintf("User %s's information updated successfully!\n\n", user(user_id).name);

end