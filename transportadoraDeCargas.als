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
one sig TransportadoraPB extends Transportadora {}
one sig TransportadoraPE extends Transportadora {}
one sig TransportadoraRN extends Transportadora {}
one sig TransportadoraAL extends Transportadora {}
one sig TransportadoraSE extends Transportadora {}
one sig TransportadoraBA extends Transportadora {}
one sig TransportadoraCE extends Transportadora {}
one sig TransportadoraPI extends Transportadora {}
one sig TransportadoraMA extends Transportadora {}

-- Criando caminhão(ões) para o transporte de pedidos
sig Caminhao {
	pedidos: set Pedido
}

sig Pedido {
--Pedido tem apenas um documento (frete)
documentos: one Documento
}

sig Documento {}

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


pred show[]{}
run show for 10
