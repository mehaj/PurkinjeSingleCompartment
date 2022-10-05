TITLE Hyperpolarisation activated cation current

COMMENT 
Kinetics adapted from model of Forrest 2014 of mammalian Purkinje cell

ENDCOMMENT

NEURON {
	SUFFIX HCN
	NONSPECIFIC_CURRENT ih
	RANGE ghbar, gh, ih, taun, ninf

}

UNITS {
	(S)= (siemens)
	(mV)=(millivolt)
	(mA)=(milliamp)
}

PARAMETER {
	ghbar=0.0001 (S/cm2)
	eh=-30 (mV)
	celsius= 27 (degC)
}

ASSIGNED {
	v (mV)
	ih (mA/cm2)
	gh (S/cm2)
	ninf
	taun	
}

STATE { n}

BREAKPOINT {
	SOLVE states METHOD cnexp
	gh=ghbar*n
	ih=gh*(v-eh)
}

UNITSOFF

INITIAL { n=ninf }

DERIVATIVE states {
	rates(v)
	n'=(ninf-n)/taun	
}

PROCEDURE rates (v) {
	LOCAL alpha, beta, Q10
	Q10=3^((celsius - 37)/10)

	:n for activation kinetics
	ninf = 1/(1+exp((v+90.1)/9.9))
	taun = (1000 * (.19 + .72*exp(-((v-(-81.5))/11.9)^2)))/Q10
}

UNITSON