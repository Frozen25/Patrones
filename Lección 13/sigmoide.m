#!/usr/bin/octave-cli

## "Capa" sigmoide, que aplica la función logística
classdef sigmoide < handle
  properties
    ## Entrada en la propagación hacia adelante
    inputs=[];
    ## Resultados después de la propagación hacia adelante
    outputs=[];
    ## Resultados después de la propagación hacia atrás
    gradient=[];
  endproperties

  methods
    ## Constructor ejecuta un forward si se le pasan datos
    function s=sigmoide(a)
      if (nargin > 1)
        print_usage();
      endif

      if (nargin == 1)
        if (isa(a,"sigmoide"))
          s.inputs=a.inputs;
          s.outputs=a.outputs;
          s.gradient=a.gradient;
        else
          forward(s,a);
        endif
      elseif
        s.inputs=[];
        s.outputs=[];
        s.gradient=[];
      endif
    endfunction

    ## Propagación hacia adelante
    function y=forward(s,a)
      if (isreal(a) && ismatrix(a))
        s.inputs=a;
        s.outputs = logistic(a);
        y=s.outputs;
        s.gradient = [];
      else
        error("sigmoide espera un vector o matriz de reales");
      endif
    endfunction

    ## Propagación hacia atrás recibe dL/ds de siguientes nodos
    function backward(s,dLds)
      if (size(dLds)!=size(s.outputs))
        error("backward de sigmoide no compatible con forward previo");
      endif
      localGrad = s.outputs.*(1-s.outputs);
      s.gradient = localGrad.*dLds
    endfunction
  endmethods
endclassdef
