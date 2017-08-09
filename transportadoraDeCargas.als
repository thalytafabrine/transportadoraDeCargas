module transportadora


one sig CentralTransportadora {

	--Criando uma central de transportadores, mas focando apenas na transportadora do nordeste.
	transportadoras: one TransportadoraNordeste
}

sig TransportadoraNordeste {
	
	--A transportadora do nordeste tem um conjunto de pedidos.
	pedidos: some Pedido
}

sig Pedido {

--Pedido tem um conjunto de documentos.
documentos: set Documento
}


fact {
	--Obrigando a central de transportadora ter apenas uma transportadora do nordeste.
	all t:CentralTransportadora | one t.transportadoras

	--Obrigando a transportadora do nordeste estar relacionada a central de transportadoras.
	all t:TransportadoraNordeste | one t.~transportadoras

	--Obrigando os pedidos a estarem relacionados a transportadora do nordeste.
	all p:Pedido | one p.~pedidos

	--Obrigando a todo pedido ter algum (pelo menos um) documento.
	all p:Pedido | some p.documentos 

	--Obrigando a todo documento estar relacionado a um pedido.
	all d:Documento | one d.~documentos

}

sig Documento {}


pred show[]{}
run show for 3
