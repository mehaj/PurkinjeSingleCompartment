TITLE Fast inactivating voltage gated sodium current

COMMENT

Kinetics adapted from model of Brown et al 2012
Mammalian model of Purkinje neuron

ENDCOMMENT

NEURON {
	SUFFIX NaF
	USEION na READ ena WRITE ina 
	RANGE gnabar, gna, ina, minf, hinf, taum, tauh
}

UNITS {
	(S)= (siemens)
	(mV)=(millivolt)
	(mA)=(milliamp)
}

PARAMETER {
	gnabar=7.5 (S/cm2)
	celsius= 27 (degC)
	ena=45 (mV)
}

ASSIGNED {
	v (mV)
	ina (mA/cm2)
	gna (S/cm2)
	minf 
	hinf
	taum
	tauh
}

STATE { m h}

BREAKPOINT {
	SOLVE states METHOD cnexp
	gna=gnabar*h*(m^3)
	ina=gna*(v-ena)
}

UNITSOFF

INITIAL {
	rates(v)
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
	Q10=3^((celsius - 37)/10)

	:m for activation kinetics
	alpham=35/exp((v+5)/(-10))
	betam=7/exp((v+65)/20)
	taum=1/(Q10*(alpham+betam))
	minf=alpham/(alpham+betam)

	:h for inactivation kinetics
	alphah=0.225/(1+exp((v+80)/10))
	betah=7.5/exp((v-3)/(-18))
	tauh=1/(Q10*(alphah+betah))
	hinf=alphah/(alphah+betah)
}

UNITSON

