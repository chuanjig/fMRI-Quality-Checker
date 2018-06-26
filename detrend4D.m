function F4D_detrended = detrend4D(functional4D_fn)
% Function to detrend 4D fMRI data
%
% INPUT:
% 
% OUTPUT: 
% F_4D_detrended        - 
%__________________________________________________________________________

F_4D = spm_read_vols(spm_vol(functional4D_fn));
[Ni, Nj, Nk, Nt] = size(F_4D);
F_2D = reshape(F_4D, Ni*Nj*Nk, Nt);
X_design = [ (1:Nt)' ((1:Nt).^2/(Nt^2))' ((1:Nt).^3/(Nt^3))'];
X_design = X_design - mean(X_design);
X_design = [X_design ones(Nt,1)];
betas = X_design\F_2D';
F_2D_detrended = F_2D' - X_design(:, 1:(end-1))*betas(1:(end-1), :);
F_2D_detrended = F_2D_detrended';
F4D_detrended = reshape(F_2D_detrended, Ni, Nj, Nk, Nt);


