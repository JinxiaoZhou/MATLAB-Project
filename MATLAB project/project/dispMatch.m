% function to print out matched user's data and preferences

function dispMatch(user_id)

    % load data file
    try
        load("pref.mat","pref");
        load("user.mat", "user");
    catch
        error("Error accessing the data file!")
    end

    % printing user data
    fprintf("Name: %s\n", user(user_id).name);
    fprintf("Age: %d\n", user(user_id).age);
    fprintf("Gender: %s\n", user(user_id).gender);
    fprintf("Height: %d\n", user(user_id).height);
    fprintf("Hair color: %s\n", user(user_id).hair_color);
    fprintf("Eye color: %s\n", user(user_id).eye_color);
    fprintf("Intro: %s\n\n", user(user_id).intro);

    % printing user pref
    fprintf("%s's preferences: \n", user(user_id).name);
    fprintf("%s's preferred age difference is: %d\n", user(user_id).name, pref(user_id).age_diff);
    fprintf("%s's preferred gender(s) is/are: %s\n", user(user_id).name, strjoin(pref(user_id).gender));
    fprintf("%s's preferred height range is: %d to %d\n", ...
        user(user_id).name, pref(user_id).height_min, pref(user_id).height_max);
    fprintf("%s's preferred hair color(s) is/are: %s\n", user(user_id).name, strjoin(pref(user_id).hair_color));
    fprintf("%s's preferred eye color(s) is/are: %s\n\n", user(user_id).name, strjoin(pref(user_id).eye_color));


end