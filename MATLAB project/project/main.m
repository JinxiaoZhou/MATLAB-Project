% initialize variables to have menu loop until properly exited
invalid_ID = 1;
menu_closed = 0;
while(invalid_ID == 1 && menu_closed == 0)
    % shows the logo (as a figure)
    imshow("twine.png")
    option_pick = menu('Welcome to Twine!', 'Login', ...
        'New Account?', 'Exit');
    switch option_pick
        case 1
            % Login
            invalid_ID = 0;
            user_id = input('Please enter your user ID: ');
            % if not, return invalid ID
            if(checkUser(user_id) == 0)
                disp(['Invalid ID, ' ...
                    'please login again or make a new account']);
                invalid_ID = 1;
            end
        case 2
            % create a new User
            newUser();
            disp('Please return to the menu and login.');
        otherwise
            % menu close
            menu_closed = 1;
            disp('Menu closed.');
    end
end

% after login successful
if(menu_closed == 0 && invalid_ID == 0)
    % load the database
    try
        load("user.mat","user");
    catch
        error("Error accessing the data file!")
    end
    while(menu_closed == 0)
        option_pick_2 = menu( ...
            sprintf('Welcome %s! What would you like to do?', ...
            user(user_id).name), ...
            'Match', 'Check Characteristics', 'Check Preferences', ...
            'Reenter Characteristics', 'Reenter Preferences', 'Check Pending Matches', 'Exit');
        switch option_pick_2
            case 1
                % match
                userMatch(user_id)
            case 2
                % display current characteristics
                dispChar(user_id);
            case 3
                % display current preferences
                dispPref(user_id);
            case 4
                % reenter char
                userEdit(user_id);
            case 5
                % reenter pref
                prefEdit(user_id);
            case 6
                % check pending matches
                % user(user_id).pending_match
                if(isempty(user(user_id).pending_match))
                    disp('There are currently no pending matches.');
                else
                    % disp(user(user_id).pending_match); debug to check
                    % user_id of who is matching
                    pending_match_arr = user(user_id).pending_match;
                    % go through the array in the struct
                    for i = 1:length(pending_match_arr)
                        % grab user ID
                        val = pending_match_arr(i);
                        % display the name
                        disp(user(val).name);
                        % display the match information
                        dispMatch(val);
                    end
                end
            otherwise
                menu_closed = 1;
                disp('Menu closed.');
        end
    end
end
