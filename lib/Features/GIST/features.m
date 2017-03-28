addpath(genpath('.'));
datasets = {'Real', 'Fake'};   
dinfo = dir('new/*.jpg'); %make sure it is the clean data file
 names_cell = {dinfo.name};
train_lists = {{names_cell{1}}, {names_cell{2}}};       
test_lists = {{names_cell{1:260}}, {names_cell{1}}};     % specify lists of test images,# of images
feature = 'gist';                                               % specify feature to use 
c = conf();                                                       % load the config structure
datasets_feature(datasets, train_lists, test_lists, feature, c);  % perform feature extraction
train_features = load_feature(datasets{1}, feature, 'train', c);  % load train features of pascal
test_features = load_feature(datasets{1}, feature, 'test', c);    % load test features of sun
csvwrite('features.csv',test_features );