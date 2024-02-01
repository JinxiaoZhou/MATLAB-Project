% returns true or false if user_id (int) exists
function user_exist = checkUser(user_id)
    user_exist = false;
    load("user.mat", "user");
    % loop through the user database
    for i = 1:length(user)
        % check if the user_id exists in the database
        if(user_id == user(i).user_id)
            user_exist = true;
        end
    end
end