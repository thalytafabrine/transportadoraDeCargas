module transportadora


one sig CentralTransportadora {

	--Criando uma central de transportadoras, que possuirá todas as transportadoras do Nordeste.
	transportadoras: set Transportadora
}

-- Assinatura de uma transportadora genérica, todas possuem um set de caminhão
abstract sig Transportadora {
	caminhoes: set Caminhao
}

-- Assinatura das transportadoras específicas de cada estado do Nordeste
one sig SedePB extends Transportadora {}
one sig FilialPE extends Transportadora {}
one sig FilialRN extends Transportadora {}
one sig FilialAL extends Transportadora {}
one sig FilialSE extends Transportadora {}
one sig FilialBA extends Transportadora {}
one sig FilialCE extends Transportadora {}
one sig FilialPI extends Transportadora {}
one sig FilialMA extends Transportadora {}

-- Criando caminhão(ões) para o transporte de pedidos
sig Caminhao {
	pedidos: set Pedido
}

sig Pedido{
--Pedido tem apenas um documento (frete)
documentos: one Documento
}

abstract sig Destino{}

one sig PB extends Destino {}
one sig PE extends Destino {}
one sig RN extends Destino {}
one sig AL extends Destino {}
one sig SE extends Destino {}
one sig BA extends Destino {}
one sig CE extends Destino {}
one sig PI extends Destino {}
one sig MA extends Destino {}


sig Documento {
destinos: one Destino
}

fact Pedido {
	--Obrigando os pedidos a estarem relacionados a um caminhao.
	all p:Pedido | one p.~pedidos
}

fact Documento {
	--Obrigando a todo documento estar relacionado a um pedido.
	all d:Documento | one d.~documentos
}

fact Caminhao {
	--Obrigando a todo caminhao estar relacionado a uma transportadora.
	all c:Caminhao | one c.~caminhoes
}

fact Transportadora {
	-- O número de instancias de Transportadora deve ser igual a 9, uma pra cada região
	#Transportadora = 9
	--Obrigando a transportadora estar relacionada a central de transportadoras.
	all t:Transportadora | one t.~transportadoras
}

fact Destino {
	all d:Destino | one d.~destinos
}


pred show[]{}
run show for 10
