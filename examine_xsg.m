
% userPath = uigetdir();

userPath = '/Volumes/genie/GeviScreenData/NeuronData-Non-production/20190304_Brainbits_GCaMP_raw_ephus/P1a-20190214_Brainbits';
savepath = '/Users/tsanga/Desktop/xsg_figures';

searchpath = fullfile(userPath, '*.xsg');
xsgFiles = dir(searchpath);


numfiles = size(xsgFiles,1);

% loop through number of xsg files. each well produces 4 files.
for i = 1:1:numfiles
    
    % determine stage position (numbers 1-80)
    % actual wells are A02 - H11
    stagepos = ceil(i/4);
    
    % load the current xsg file
    filepath = fullfile(userPath, xsgFiles(i,1).name);
    temp_xsg = load(filepath, '-mat');
    
    
    % extract AP train number
    uscore = strfind(xsgFiles(i,1).name, '_');
    FPnum = extractAfter(xsgFiles(i,1).name, uscore(1,7));
    atloc = strfind(FPnum, '@');
    FPnum = extractBefore(FPnum, atloc);
    
    % extract well position
    wellpos = extractBetween(xsgFiles(i,1).name, uscore(1,1)+1, uscore(1,2)-1);
    wellpos = char(wellpos);
    
    % plot and display info
    
    subplotpos = mod(i,4);
    
    if subplotpos == 1
        h = figure;
    end
    
    
    if subplotpos == 1
        p = 1;
    elseif subplotpos == 2
        p = 2;
    elseif subplotpos == 3
        p = 3;
    elseif subplotpos == 0
        p = 4;
    end
    
    subplot(2,2,p)
    plot(temp_xsg.data.acquirer.trace_2)
    text(4e4, 1, FPnum, 'Color', 'red', 'FontSize', 14)
    text(4e4, 1.2, wellpos, 'Color', 'red', 'FontSize', 14)
    
    
    if subplotpos == 0
        figname = strcat(wellpos, '_', FPnum, '.jpg');
        saveas(h,fullfile(savepath,figname),'jpeg');
        close(h);        
    end
    
    
end


% % example address xsg file
% filepath = fullfile(userPath, xsgFiles(1,1).name);
%
% % example load xsg command
% z = load(filepath, '-mat');
%
% plot(z.data.acquirer.trace_2)