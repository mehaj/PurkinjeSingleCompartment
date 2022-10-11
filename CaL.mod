TITLE L-type high voltage gated calcium channel

COMMENT
    Translated from GENESIS by Johannes Luthman and Volker Steuber. 
    This mechanism and the other calcium channel (CaLVA.mod) are the only channel
    mechanisms of the DCN model that use the GHK mechanism to calculate reversal
    potential. Thus, extracellular Ca concentration is of importance and shall be 
    set from hoc.

    Calcium entering the neuron through this channel is kept track of by CaConc.mod
    and affects the conductance of the SK.mod channel mechanism.
ENDCOMMENT 

NEURON { 
	SUFFIX CaL 
	USEION ca READ cai, cao WRITE ica
	RANGE gcabar, ica, m, cai
	
} 
 
UNITS { 
	(mA) = (milliamp) 
	(mV) = (millivolt) 
	(molar) = (1/liter)
	(mM) = (millimolar)
} 
 
PARAMETER { 
 
    gcabar=0.005
	
} 

ASSIGNED {
	v (mV)
    cai(mM)
    cao (mM)     
	ica (mA/cm2) 
	minf (1)
	taum (ms) 
	celsius (degC)
	T (kelvin)
    A (1)
} 

STATE {
	m
} 

INITIAL { 
    T = 273.15 + celsius
    rate(v)
    m = minf 
} 
 
BREAKPOINT { 
    SOLVE states METHOD cnexp 
    A = getGHKexp(v)
    ica = gcabar * m*m*m * (4.47814e6 * v / T) * ((cai/1000) - (cao/1000) * A) / (1 - A)
} 
 
DERIVATIVE states { 
	rate(v) 
	m' = (minf - m)/taum 
} 

PROCEDURE rate(v(mV)) {
	LOCAL Q10
	TABLE minf, taum FROM -150 TO 100 WITH 300
	Q10=3^((celsius-37)/10)
    minf = 1 / (1 + exp((v +34) / -9))
    taum =1 / ((31.746 * ((exp((v - 5) / -13.89) + 1) ^ -1)) + (3.97e-4 * (v + 8.9)) * ((exp((v + 8.9) / 5) - 1) ^ -1))
    taum = taum / Q10
} 

FUNCTION getGHKexp(v(mV)) {
    TABLE DEPEND T FROM -150 TO 100 WITH 300 
    getGHKexp = exp(-23.20764929 * v / T)
}


