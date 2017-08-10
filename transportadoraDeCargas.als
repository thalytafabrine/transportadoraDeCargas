module transportadora


one sig CentralTransportadora {

	--Criando uma central de transportadoras, que possuirá todas as transportadoras do Nordeste.
	transportadoras: set Transportadora
}

-- Assinatura de uma transportadora genérica, todas possuem um set de pedidos
abstract sig Transportadora {
	pedidos: set Pedido
}

-- Assinatura das transportadoras específicas de cada estado do Nordeste
one sig TransportadoraPB extends Transportadora {}
one sig TransportadoraPE extends Transportadora {}
one sig TransportadoraRN extends Transportadora {}
one sig TransportadoraAL extends Transportadora {}
one sig TransportadoraSE extends Transportadora {}
one sig TransportadoraBA extends Transportadora {}
one sig TransportadoraCE extends Transportadora {}
one sig TransportadoraPI extends Transportadora {}
one sig TransportadoraMA extends Transportadora {}

sig Pedido {

--Pedido tem apenas um documento (frete)
documentos: one Documento
}


fact {

	--Obrigando os pedidos a estarem relacionados a transportadora do nordeste.
	all p:Pedido | one p.~pedidos

	--Obrigando a todo documento estar relacionado a um pedido.
	all d:Documento | one d.~documentos

}

fact Transportadora {
	-- O número de instancias de Transportadora deve ser igual a 9, uma pra cada região
	#Transportadora = 9
	--Obrigando a transportadora estar relacionada a central de transportadoras.
	all t:Transportadora | one t.~transportadoras
}

sig Documento {}


pred show[]{}
run show for 10
