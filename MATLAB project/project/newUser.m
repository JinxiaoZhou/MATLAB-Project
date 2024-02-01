% function to create new user (and struct if not present)

function newUser()

    % create the user struct if not present
    if ~isfile("user.mat")
    
        user = struct( ...
            "user_id", 1, "name", "Tianyu Zhang", "age", 22, "gender", ...
            "male", "height", 181, "hair_color", "black", "eye_color", ...
            "brown","intro", "Hello my name is Tianyu.", "pending_match", []);
    
        save("user.mat","user");
    
    end

    % create the pref struct if not present
    if ~isfile("pref.mat")
    
        pref = struct("user_id", 1, "age_diff", 5, "gender", ["female", "other"],...
            "height_min", 150, "height_max", 180, "hair_color", ...
            ["black", "blonde"], "eye_color", ["brown", "black", "blue"]) ...
            ;
    
        save("pref.mat","pref");

    end

    
    % load the db and get the latest user_id + 1
    try
        load("user.mat","user");
    catch
        error("Error accessing the data file!")
    end
    
    user_id = user(end).user_id + 1;
    
    % call userEdit to create user, prefEdit to create user prefs.
    try
        userEdit(user_id);
        prefEdit(user_id);
    catch
        error("Error creating the user!")
    end

    %load again to get user's name
    try
        load("user.mat","user");
    catch
        error("Error accessing the data file!")
    end
    fprintf("User %s created successfully!\n", user(user_id).name);
    fprintf("Your user ID is: %d\n\n", user_id);

end
