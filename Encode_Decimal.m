function pop=Encode_Decimal(par,sig,dec)

% ENCODE Encode parameters to base-10 chromosome strings 
%
% Input: 	par		: parameters
%  			sig		: significant figures
%			dec		: decimal point
% Output:   chrom   : chromosomes
%

% Programmed by: Huynh Thai Hoang
% Last updated : November 25, 2005

if (nargin < 3),
   error(['Too few input arguments. Use: pop=encode(par,sig,dec)']);
end;

if size(sig)~=size(dec),
   error(['Mismatch betweem SIG and DEC']);
end;

[pop_size,npar]=size(par);

for pop_index = 1:pop_size,				% population pointer
  	gene_index = 1;
    for par_index = 1:npar,  			% parameter pointer                   
        
        % First, we transfer the sign of the parameters into the chromosome
        if par(pop_index,par_index) < 0
            pop(pop_index,gene_index)=0;
        else
            pop(pop_index,gene_index)=9;
        end
        gene_index=gene_index+1;

		temp(par_index)=abs(par(pop_index,par_index))/10^dec(par_index);               
        % Encode the parameters into chromosome form 
        
		for count = 1:sig(par_index),
            temp(par_index)=temp(par_index)*10;
            pop(pop_index,gene_index)=temp(par_index)-rem(temp(par_index),1);
      	    temp(par_index)=temp(par_index)-pop(pop_index,gene_index);
            gene_index=gene_index+1;
        end         
   end % End "for par_index=..." loop
end    % End "for pop_index=..." loop

