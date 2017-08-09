module transportadora


sig Pedido {

--Pedido tem um conjunto de documentos.
documentos: set Documento

}

fact {

	--Obrigando a todo pedido ter algum (pelo menos um) documento.
	all p:Pedido | some p.documentos 
	--Obrigando a todo documento estar relacionado a um pedido.
	all d:Documento | one d.~documentos

}

sig Documento {}


pred show[]{}
run show for 3
