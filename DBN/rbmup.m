function act_hid = rbmup(rbm, vis,ey,act_func)
%%RBMUP calculate p(h=1|v)
% INPUTS
%   rbm        : A rbm struct
%   vis        : the activation of the visible layer
%   ey         : if classRBM the activation of the class labels
%   act_func   : the activation function, either @sigm or @sigmrnd
%
% OUTPUTS
%   act_of_hid : the activation of the hidden layer
%
% see "A practical guide to training restricted Boltzmann machines" eqn 7
% act is the activation function. Currently either sigm or sigmrnd
%
%
% NOTATION
%    v  : all data given as      [n_samples   x #vis]
%   ey  : all data given as      [n_samples   x #n_classes]
%    W  : vis - hid weights      [ #hid       x #vis ]
%    U  : label - hid weights    [ #hid       x #n_classes ]
%    b  : bias of visible layer  [ #vis       x 1]
%    c  : bias of hidden layer   [#hid       x 1]
%    d  : bias of label layer    [#n_classes x 1]
% Copyright S�ren S�nderby June 2014



% activation from hidden units
act_hid = bsxfun(@plus,vis * rbm.W',rbm.c');

% for the hinton DBN add the activation coming from the label visible units
if rbm.classRBM == 1
    act_hid  = bsxfun(@plus,act_hid,ey*rbm.U');
end
act_hid = act_func(act_hid); %apply activation function
