TITLE Small conductance calcicum activated potassium channel

COMMENT 
Kinetics file taken from Masoli et al 

ENDCOMMENT

NEURON {
	SUFFIX SK
	USEION ca READ cai
	USEION k READ ek WRITE ik
	RANGE gkbar, gk, ik, cai 
}

UNITS {
	(S)= (siemens)
	(mV)=(millivolt)
	(mA)=(milliamp)
	(molar) = (1/liter)
	(mM) = (millimolar)
}

PARAMETER {
	gkbar= 0.038 (S/cm2)
	cai (mM)
	ek=-70 (mV)
	celsius= 27 (degC)
}

ASSIGNED {
	v (mV)
	ik (mA/cm2)
	gk (S/cm2)
	minf
	hinf
	taum
	tauh	
}

STATE { m h}
