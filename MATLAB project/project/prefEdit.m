% function to edit a user's preferences in the pref struct in pref.mat

function prefEdit(user_id)

    % test file
    if ~isfile("pref.mat")
        error("Data file not present. Initialize database by creating a new user!");
    end

    %load data file
    try
        load("pref.mat","pref");
        load("user.mat","user"); % solely for displaying success msg
    catch
        error("Error accessing the data file!")
    end
    
    % user input and save file
    disp("We will now ask for your preferences.");
    
    try
        pref(user_id).user_id = user_id;
        pref(user_id).age_diff = input("Please enter your preferred age difference: ");
        pref(user_id).gender = transpose(split(string(input("Please enter your preferred gender(s), seprated by space: ", "s"))));
        pref(user_id).height_min = input("Please enter your preferred height - minimum: ");
        pref(user_id).height_max = input("Please enter your preferred height - maximum: ");
        pref(user_id).hair_color = transpose(split(string(input("Please enter your preferred hair color(s), seprated by space: ", "s"))));
        pref(user_id).eye_color = transpose(split(string(input("Please enter your preferred eye color(s), seprated by space: ", "s"))));

        save("pref.mat","pref");

    catch
        error("Error editing the preferences!");
    end

    fprintf("User %s's preferences updated successfully!\n\n", user(user_id).name);

end