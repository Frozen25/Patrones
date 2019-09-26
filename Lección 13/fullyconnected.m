#!/usr/bin/octave-cli

## "Capa" fullyconnected, que simplemente hace Wx
classdef fullyconnected < handle
  properties
    ## Entrada de parametros en la propagación hacia adelante
    inputsW=[];
    ## Entrada de valores en la propagación hacia adelante
    inputsX=[];
    
    ## Resultados después de la propagación hacia adelante
    outputs=[];
    ## Resultados después de la propagación hacia atrás
    gradientW=[];
    gradientX=[];
  endproperties

  methods
    ## Constructor ejecuta un forward si se le pasan datos
    function s=fullyconnected(a)
      if (nargin > 2)
        print_usage();
      endif

      if (nargin == 1)
        if (isa(a,"fullyconnected"))
          s.inputsW=a.inputsW;
          s.inputsX=a.inputsX;
          s.outputs=a.outputs;
          s.gradientX=a.gradientX;
          s.gradientW=a.gradientW;
        else
          s.inputsX=[];
          s.inputsW=[];
          s.outputs=[];
          s.gradientX=[];
          s.gradientW=[];
        endif
      else
        s.inputsX=[];
        s.inputsW=[];
        s.outputs=[];
        s.gradientX=[];
        s.gradientW=[];
      endif
    endfunction

    ## Propagación hacia adelante realiza W*x
    function y=forward(s,W,x)
      if (isreal(W) && ismatrix(W) && isreal(x) && ismatrix(x))
        s.inputsX=x;
        s.inputsW=W;
        s.outputs = W*x;
        y=s.outputs;
        s.gradientX = [];
        s.gradientW = [];
      else
        error("fullyconnected espera matriz y vector de reales");
      endif
    endfunction

    ## Propagación hacia atrás recibe dL/ds de siguientes nodos
    function backward(s,dLds)
      if (columns(dLds)!=1)
        error("backward requiere gradiente entrante como vector columna");
      endif
      s.gradientW = dLds*s.inputsX';
      s.gradientX = s.inputsW'*dLds;
    endfunction
  endmethods
endclassdef
