%% Dump Features to Weka Files..
%   Write features to .arff weka files..    
%   
%   dumpFeaturesToWeka(FEATURES, LABELS)
%
%   --FEATURES Matrix
%   --LABELS Cell

function dumpFeaturesToWeka(features, labels, file_path)
    system_options = setSystemOptions();
    TARGET_DIR = system_options.TARGET_DIR;
    
    if nargin < 3
        DEAFAULT_NAME = system_options.DEFAULT_NAME;
        file_path = DEAFAULT_NAME;
    end

    file_path = strcat(TARGET_DIR, file_path);
    fid = fopen(strcat(file_path, '.arff'), 'w');
    
    if(fid < 0)
        fprintf('ERROR:[INVALID FID] File path = %s', ...
                    file_path);
        return
    end
    
    fprintf(fid, '@RELATION bodyguard\r\n\r\n'); 

    for k = 1:size(features, 2)
        fprintf(fid, '@ATTRIBUTE feature_%d NUMERIC\r\n', k);
    end

    labelsList = unique(labels);    
    tempLabelsStr = '';
    for k = 1:length(labelsList)
        tempLabelsStr = sprintf('%s%s ', ...
                            tempLabelsStr, labelsList{k});
    end
    
    tempLabelsStr = sprintf('@ATTRIBUTE class {%s}\r\n', ...
                            tempLabelsStr);
    fprintf(fid, tempLabelsStr);
    fprintf(fid, '@DATA\r\n');

    for k = 1:size(features, 1)
        for kk = 1:size(features, 2)
            fprintf(fid, '%g, ', features(k, kk));
        end
        fprintf(fid, '%s\n', labels{k});
    end

    fclose(fid);
end

