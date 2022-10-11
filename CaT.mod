TITLE Transient calcium current

COMMENT 
Kinetics adapted from model of Brown et al 2012
Mammalian model of Purkinje neuron

ENDCOMMENT

NEURON {
	SUFFIX CaT
	USEION ca READ cai, cao WRITE ica 
	RANGE gcabar, gca, ica, minf, hinf, taum, tauh
}

UNITS {
	(S)= (siemens)
	(mV)=(millivolt)
	(mA)=(milliamp)
}

PARAMETER {
	gcabar= 0.0005 (S/cm2)
	eca= 135 (mV)
	cai=4e-5 (mM)
	cao= 2.1 (mM)	 :based on external saline composition
	celsius= 27 (degC)
}

ASSIGNED {
	v (mV)
	ica (mA/cm2)
	gca (S/cm2)
	minf
	hinf
	taum
	tauh	
}

STATE { m h}

BREAKPOINT {
	SOLVE states METHOD cnexp
	gca=gcabar*m*h
	ica=gca*(v-eca)
}

UNITSOFF

INITIAL {
	rates (v)
	m=minf
	h=hinf
}

DERIVATIVE states {
	rates(v)
	m'=(minf-m)/taum
	h'=(hinf-h)/tauh
}

PROCEDURE rates (v) {
	LOCAL alpham, betam, alphah, betah, Q10
	TABLE minf, taum, hinf, tauh DEPEND celsius FROM -400 TO 300 WITH 2100
	Q10=3^((celsius - 37)/10)

	:m for activation kinetics
	alpham = 2.6/(1+exp((v+21)/(-8)))
    betam =  0.18/(1+exp((v+40)/4))
	taum=1/(Q10*(alpham+betam))
	minf=alpham/(alpham+betam)

	:h for inactivation kinetics
	alphah = 0.0025/(1+exp((v+40)/8))
    betah = 0.19/(1+exp((v+50)/(-10)))
	tauh=1/(Q10*(alphah+betah))
	hinf=alphah/(alphah+betah)
}

UNITSON