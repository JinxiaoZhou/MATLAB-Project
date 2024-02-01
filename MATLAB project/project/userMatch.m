% function to calculate match score for the input user_id,
% and run match for current user from score high to low

%function sorted_score = userMatch(user_id)
function userMatch(user_id)
    % load databases
    try
        load("user.mat","user");
        load("pref.mat","pref");
    catch
        error("Error accessing the data file!")
    end

    % calculate age_min and age_max
    age_min = user(user_id).age - pref(user_id).age_diff;
    age_max = user(user_id).age - pref(user_id).age_diff;

    % looping through all users in db except self and give a match score.
    % Each pref match will give one score. Scores will be stored in a struct:

    score = struct("user_id", 1, "score", 0);

    % list of pref: age gender  height  hair_color  eye_color
    % scores each:  3   10       2       1           1

    % score loops
    for i = 1:user(end).user_id

        % initialize score for target user in current iteration
        score(i).user_id = i;
        
        if i ~= user_id
            
            % everyone get at least 1 except self
            score(i).score = 1; 

            % age (3 points)
            if user(i).age >= age_min && user(i).age <= age_max

                score(i).score = score(i).score + 3;
                
            end

            % gender (10 points)
            % loop through all prefered genders
            for j = 1:size(pref(user_id).gender, 2)

                if strcmpi(pref(user_id).gender(j), user(i).gender)

                    score(i).score = score(i).score + 10;

                end
                
            end

            % height (2 points)
            if user(i).height >= pref(user_id).height_min && user(i).height <= pref(user_id).height_max

                score(i).score = score(i).score + 2;
                
            end

            % hair_color (1 point)
            % loop through all prefered hair colors
            for j = 1:size(pref(user_id).hair_color, 2)

                if strcmpi(pref(user_id).hair_color(j), user(i).hair_color)

                    score(i).score = score(i).score + 1;

                end
                
            end

            % eye_color (1 point)
            % loop through all prefered eye colors
            for j = 1:size(pref(user_id).eye_color, 2)

                if strcmpi(pref(user_id).eye_color(j), user(i).eye_color)

                    score(i).score = score(i).score + 1;

                end
                
            end

        else

            % -1 for self as a invalid indicator
            score(i).score = -1; 

        end

    end

    % convert to table to sort and convert back to struct
    temp_score = struct2table(score);
    sorted_temp_score = sortrows(temp_score, "score", "descend");
    sorted_score = table2struct(sorted_temp_score);

    sorted_score(end) = []; % remove self from sorted_score


% test code:
%     for i = 1:size(sorted_score)
% 
%         fprintf("ID = %d Score = %d\n", sorted_score(i).user_id, sorted_score(i).score);
% 
%     end

    inputYes = 0;
    i = 1;
    sorted_ind = size(sorted_score);
    disp(sorted_ind);
    user_ind = sorted_ind(1);
    disp(user_ind);
    
    while ((inputYes == 0) && (i < user_ind))

        target_user_id = sorted_score(i).user_id; 
        % i created a new var just to make the code short,
        % it was hilarius that i used this three times in one line -Tianyu

        fprintf("\nNext match: \n\n");
        fprintf("Match score: %d\n", sorted_score(i).score);

        % display using modified wording 

        % dispChar(target_user_id);
        % dispPref(target_user_id);
        dispMatch(target_user_id);

        option_pick = menu(sprintf("Do you want to match with %s?", ...
            user(target_user_id).name), 'Yes', 'No', 'Exit Matching');

        switch option_pick
            case 1
                
                % yes
                pending_match_size = size(user(target_user_id).pending_match, 2);
                
                % check if already matched
                skip_current = 0;
                
                for j = 1:pending_match_size

                    if user(target_user_id).pending_match(j) == user_id

                        fprintf("Already matched with %s, no action will be taken!\n", user(target_user_id).name);
                        skip_current = 1;
                        break

                    end

                end

                % matching sequence
                if skip_current == 0

                    % check if other person matched too, if not then
                    % append id to user(target_user_id).pending_match
                    match = 0;
                    self_pending_match_size = size(user(user_id).pending_match, 2);

                    for j = 1:self_pending_match_size

                        if user(user_id).pending_match(j) == target_user_id
    
                            fprintf("Congratulations! You and %s matched each other.", user(target_user_id).name);
                            user(user_id).pending_match(j) = -1; % invalidate this match
                            match = 1;
                            break
    
                        end

                    end

                    % append if no match
                    if match == 0
                        user(target_user_id).pending_match(pending_match_size + 1) = user_id;
                    end

                    save("user.mat", "user");
                end
                i = i+1;
            case 2
                % no
                i = i+1;
            otherwise
                % exit
                inputYes = 1;
                disp('Exiting Matching Program.');
        end
    end
    % if go through the entire database, exit
    if(inputYes == 0)
        disp('No more possible matches, come again later!');
    end

    %save("user.mat", "user");
    
end