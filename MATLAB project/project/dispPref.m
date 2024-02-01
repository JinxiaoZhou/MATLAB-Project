% function to print out user's preferences

function dispPref(user_id)

    % load data file
    try
        load("pref.mat","pref");
    catch
        error("Error accessing the data file!")
    end

    % printing user pref
    fprintf("Your preferred age difference is: %d\n", pref(user_id).age_diff);
    fprintf("Your preferred gender(s) is/are: %s\n", strjoin(pref(user_id).gender));
    fprintf("Your preferred height range is: %d to %d\n", ...
        pref(user_id).height_min, pref(user_id).height_max);
    fprintf("Your preferred hair color(s) is/are: %s\n", strjoin(pref(user_id).hair_color));
    fprintf("Your preferred eye color(s) is/are: %s\n\n", strjoin(pref(user_id).eye_color));


end