TITLE Fast inactivating voltage gated potassium current

COMMENT 
Kinetics adapted from model of Brown et al 2012
Mammalian model of Purkinje neuron

ENDCOMMENT

NEURON {
	SUFFIX Ka
	USEION ca READ cai 
	USEION k READ ek WRITE ik 
	RANGE gkbar, gk, ik, minf, hinf,zinf, taum, tauh, tauz
}

UNITS {
	(S)= (siemens)
	(mV)=(millivolt)
	(mA)=(milliamp)
	(molar) = (1/liter)
	(mM) = (millimolar)	
}

PARAMETER {
	gkbar= 0.015 (S/cm2)
	ek=-70 (mV)
	celsius= 27 (degC)
}

ASSIGNED {
	v (mV)
	ik (mA/cm2)
	gk (S/cm2)
	minf
	hinf
	zinf
	taum
	tauh
	tauz	
}

STATE { m h z}

INTIAL {
	rates (v)
	m=minf
	h=hinf
	z=zinf
}

BREAKPOINT {
	SOLVE states METHOD cnexp
	gk=gkbar*(m^3)*(z^2)*h 
	ik=gk*(v-ek)
}

DERIVATIVE states {
	rates (v)
	m'=(minf-m)/taum 
	h'=(hinf-h)/tauh 
	z'=(zinf-z)/tauz 
}

PROCEDURE rates (v (mV)) {
	v=v+5 (mV)
	minf = 1 / ( 1+exp(-(v+28.9)/6.2) )
	taum = (1e3) * ( 0.000505 + 1 (s) / ( exp(-(v+86.4)/-10.1 ) + exp(-(v+-33.3 )/10 ) ) ) / Q10
	
	zinf = 1 /(1 + 0.001 /cai)
    tauz = 1/Q10

	hinf = 0.085+ (1-0.085) / ( 1+exp(-(v+32)/-5.8) )
	tauh = (1e3) * ( 0.0019 + 1 (s) / ( exp(-(v+48.5)/(-5.2)) + exp(-(v+(-54.2))/12.9) ) ) / Q10
}