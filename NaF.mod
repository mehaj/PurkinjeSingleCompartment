TITLE Fast inactivating voltage gated sodium current

COMMENT

Kinetics adapted from model of Brown et al 2012
Mammalian model of Purkinje neuron

ENDCOMMENT

NEURON {
	SUFFIX NaF
	USEION na READ ena WRITE ina 
	RANGE gnabar, gna, ina 
}

UNITS {
	(S)= (siemens)
	(mV)=(millivolt)
	(mA)=(milliamp)
}

PARAMETER {gnabar= (S/cm2)}

ASSIGNED {
	v (mV)
	ena (mV)
	ina (mA/cm2)
	gna (S/cm2)
}

STATE { m h}

BREAKPOINT {
	SOLVE states METHOD cnexp
	gna=gbar*h*(m^3)
	ina=gna*(v-ena)
}

INITIAL {
	m=alpham(v)/(alpham(v)+betam(v))
	h=alphah(v)/(alphah(v)+betah(v))
}

DERIVATIVE states {
	m'=(1-m)*alpham(v)-n*betam(v)
	h'=(1-h)*alphah(v)-h*betah(v)
}

FUNCTION alpham (Vm (mV)) (/ms) {
	alpham=35/exp((Vm+5)/(-10))
}

FUNCTION betam (Vm (mV)) (/ms) {
	betam=7/exp((Vm+65)/20)
}

FUNCTION alphah (Vm (mV)) (/ms) {
	alphah=0.225/(1+exp((Vm+80)/10))
}

FUNCTION betah (Vm (mV)) (/ms) {
	betah=7.5/exp((v-3)/(-18))
}