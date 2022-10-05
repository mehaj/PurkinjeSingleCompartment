TITLE Fast inactivating voltage gated potassium current

COMMENT 
Kinetics adapted from model of Brown et al 2012
Mammalian model of Purkinje neuron

ENDCOMMENT

NEURON {
	SUFFIX Ka
	USEION k READ ek WRITE ik 
	RANGE gkbar, gk, ik, minf, hinf, taum, tauh
}

UNITS {
	(S)= (siemens)
	(mV)=(millivolt)
	(mA)=(milliamp)
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
	taum
	tauh	
}

STATE { m h}

BREAKPOINT {
	SOLVE states METHOD cnexp
	gk=gkbar*h*(m^4)
	ik=gk*(v-ek)
}

UNITSOFF

INITIAL {
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
	alpham = 1.4/(1+exp((v+27)/(-12)))
    betam =  0.49/(1+exp((v+30)/4))
	taum=1/(Q10*(alpham+betam))
	minf=alpham/(alpham+betam)

	:h for inactivation kinetics
	alphah = 0.0175/(1+exp((v+50)/8))
    betah = 1.3/(1+exp((v+13)/(-10)))
	tauh=1/(Q10*(alphah+betah))
	hinf=alphah/(alphah+betah)
}

UNITSON